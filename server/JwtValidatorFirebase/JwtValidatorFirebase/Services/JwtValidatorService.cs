using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using FirebaseAdmin;
using FirebaseAdmin.Auth;
using Google.Apis.Auth.OAuth2;
using JwtValidatorFirebase.Enums;
using JwtValidatorFirebase.Interfaces;
using JwtValidatorFirebase.Models;

namespace JwtValidatorFirebase.Services
{
    public class JwtValidatorService : IJwtValidatorService, IDisposable
    {
        public const string TokenHeaderName = "Authorization";
        private ConcurrentDictionary<string, ValidatorResponse> ResponseCache { get; set; }
        private readonly CancellationTokenSource _cancellationTokenSource;
        private readonly Task _clearTask;

        private ValidatorResponse _anonymousUser;

        public JwtValidatorService()
        {
            _anonymousUser = new ValidatorResponse();
            _anonymousUser.SetRole(HasuraRoles.Anonymous);

            _cancellationTokenSource = new CancellationTokenSource();
            ResponseCache = new ConcurrentDictionary<string, ValidatorResponse>();
            FirebaseApp.Create(new AppOptions()
            {
                //Check [$env:GOOGLE_APPLICATION_CREDENTIALS] variable for app
                Credential = GoogleCredential.GetApplicationDefault()
            });

            _clearTask = RunCacheClearTask();
        }

        public int GetCacheSize()
        {
            return ResponseCache.Count;
        }

        /// <summary>
        /// Generates Custom (NOT ID!) token
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public async Task<string> GenerateCustomTokenAsync(string uid)
        {
            var token = await FirebaseAuth.DefaultInstance.CreateCustomTokenAsync(uid);
            return token;
        }


        /// <summary>
        /// Validates Id token (NOT CUSTOM!)
        /// </summary>
        /// <param name="rawJwt"></param>
        /// <param name="useCache"></param>
        /// <returns></returns>
        public async Task<ValidatorResponse> ValidateIdTokenAsync(string rawJwt, bool useCache = true)
        {
            if (string.IsNullOrWhiteSpace(rawJwt))
                return _anonymousUser;

            var isCached = ResponseCache.TryGetValue(rawJwt, out var storedResponse);
            if (isCached)
                return storedResponse;
            var response = await InternalValidationAsync(rawJwt);
            ResponseCache.TryAdd(rawJwt, response);
            return response;
        }

        private async Task<ValidatorResponse> InternalValidationAsync(string rawJwt)
        {
            var response = new ValidatorResponse();
            try
            {
                var firebaseToken = await FirebaseAuth.DefaultInstance.VerifyIdTokenAsync(rawJwt);
                if (firebaseToken.ExpirationTimeSeconds <= 0)
                {
                    response.SetRole(HasuraRoles.Anonymous);
                    return response;
                }

                response.UserId = firebaseToken.Uid;
                response.ValidUntil = DateTime.UtcNow + TimeSpan.FromSeconds(firebaseToken.ExpirationTimeSeconds);

                response.SetRole(HasuraRoles.User);
            }
            catch (FirebaseAdmin.Auth.FirebaseAuthException e)
            {
                Console.WriteLine(e.Message);
                response.Error = e.Message;
                response.IsValidated = false;
            }

            return response;
        }


        public void Dispose()
        {
            _cancellationTokenSource.Cancel();
            ResponseCache.Clear();
            _cancellationTokenSource.Dispose();
            _clearTask.Dispose();
        }

        private Task RunCacheClearTask()
        {
            var ct = _cancellationTokenSource.Token;
            var task = Task.Run(async () =>
            {
                ct.ThrowIfCancellationRequested(); // Were we already canceled?
                var taskRunning = true;
                while (taskRunning)
                {
                    List<string> keys;
                    lock (ResponseCache)
                    {
                        keys = ResponseCache.Keys.ToList();
                    }

                    foreach (var k in keys)
                    {
                        var isFound = ResponseCache.TryGetValue(k, out var stored);
                        if (!isFound) continue;

                        //Clear if token is invalid
                        if (!stored.IsValidated || !stored.ValidUntil.HasValue || stored.ValidUntil < DateTime.UtcNow)
                            ResponseCache.TryRemove(k, out var _);

                        //Clear if token was vaildated long ago
                        if (stored.WhenValidated < (DateTime.UtcNow + TimeSpan.FromDays(-1)))
                            ResponseCache.TryRemove(k, out var _);
                    }

                    await Task.Delay(TimeSpan.FromSeconds(10), ct);
                    if (ct.IsCancellationRequested)
                        taskRunning = false;
                }
            }, _cancellationTokenSource.Token);
            return task;
        }
    }
}
