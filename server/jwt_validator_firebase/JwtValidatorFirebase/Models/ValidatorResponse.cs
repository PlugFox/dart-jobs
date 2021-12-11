using System;
using System.Globalization;
using System.Text.Json.Serialization;
using JwtValidatorFirebase.Enums;

namespace JwtValidatorFirebase.Models
{
    public class ValidatorResponse
    {
        /// <summary>
        /// X-Hasura-User-Id
        /// </summary>
        [JsonPropertyName("X-Hasura-User-Id")]
        public string UserId { get; private set; }

        /// <summary>
        /// X-Hasura-Role
        /// </summary>
        [JsonPropertyName("X-Hasura-Role")]
        public string Role { get; private set; }

        [JsonPropertyName("Expires")]
        public string Expires => ValidUntil?.ToUniversalTime().ToString("ddd, dd MMM yyyy HH:mm:ss 'GMT'", CultureInfo.InvariantCulture);

        [JsonPropertyName("Cache-Control")]
        public string CacheControl => ExpirationTimeSeconds != null ? $"max-age={ExpirationTimeSeconds}" : null;

        [JsonPropertyName("X-JWT-Error")]
        public string ErrorMessage { get; private set; }

        [JsonIgnore]
        public bool IsValidated { get; private set; }

        [JsonIgnore]
        public DateTime? WhenValidated { get; private set; }

        [JsonIgnore]
        public DateTime? ValidUntil { get; private set; }

        [JsonIgnore]
        public long? ExpirationTimeSeconds { get; private set; }

        public void SetUser(string userId, long expirationTimeSeconds)
        {
            if (userId == null) {
                SetAnonymous();
                return;
            }
            Role = "user";
            UserId = userId;
            ExpirationTimeSeconds = expirationTimeSeconds;
            ValidUntil = DateTime.UtcNow + TimeSpan.FromSeconds(expirationTimeSeconds);
            _setValidated();
        }

        public void SetAnonymous()
        {
            Role = "anonymous";
            UserId = null;
            ExpirationTimeSeconds = null;
            ValidUntil = null;
            _setValidated();
        }

        public void SetError(string message)
        {
            ErrorMessage = message;
            IsValidated = false;
            WhenValidated = null;
            ValidUntil = null;
            UserId = null;
            Role = null;
        }

        private void _setValidated() {
            IsValidated = true;
            WhenValidated = DateTime.UtcNow;
        }
    }
}
