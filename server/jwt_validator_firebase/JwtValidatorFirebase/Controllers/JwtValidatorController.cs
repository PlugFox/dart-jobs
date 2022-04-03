using System;
using System.Threading.Tasks;
using JwtValidatorFirebase.Interfaces;
using JwtValidatorFirebase.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sentry;

namespace JwtValidatorFirebase.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class JwtValidatorController : ControllerBase
    {
        private readonly IJwtValidatorService _jwtValidatorService;
        private readonly ILogger<HealthCheckController> _logger;
        private readonly System.Text.Json.JsonSerializerOptions _jsonSerializerOptions;

        private readonly IHub _sentryHub;

        public JwtValidatorController(ILogger<HealthCheckController> logger, IJwtValidatorService jwtValidatorService, IHub sentryHub)
        {
            _logger = logger;
            _jwtValidatorService = jwtValidatorService ?? throw new ArgumentNullException(nameof(jwtValidatorService));
            _jsonSerializerOptions = new System.Text.Json.JsonSerializerOptions
            {
                WriteIndented = false,
                DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingDefault
            };
            _sentryHub = sentryHub;
        }

        [HttpGet]
        public async Task<IActionResult> GetValidationResult()
        {

            var childSpan = _sentryHub.GetSpan()?.StartChild("get-validator-result");
            try
            {
                #if DEBUG
                _logger.LogDebug("Get validation result");
                #endif
                Response.Headers.Add("Content-Type", "application/json; charset=utf-8");
                Request.Headers.TryGetValue(JwtValidatorService.TokenHeaderName, out var jwtToken);
                var validatedResult = await _jwtValidatorService.ValidateIdTokenAsync(jwtToken);
                Response.StatusCode = validatedResult.IsValidated ? 200 : 401;
                var result = Content(
                    System.Text.Json.JsonSerializer.Serialize(
                        validatedResult,
                        _jsonSerializerOptions
                    )
                );
                childSpan?.Finish(SpanStatus.Ok);
                return result;
            }
            catch (Exception e)
            {
                childSpan?.Finish(e);
                Response.Headers.Add("Content-Type", "application/json; charset=utf-8");
                Response.StatusCode = 401;
                _logger.LogError(e, "Error while validating token");
                return Content($"{{\"X-JWT-Error\":\"{e.Message}\"}}"); 
            }
        }

        /*
        [HttpGet("generate/{uid}")]
        public async Task<IActionResult> GetCustomToken(string uid)
        {
            var token = await _jwtValidatorService.GenerateCustomTokenAsync(uid);
            return Ok(token);
        }
        */

        [HttpGet("cache-size")]
        public IActionResult GetCacheSize()
        {
            var childSpan = _sentryHub.GetSpan()?.StartChild("get-cache-size");
            try {
                #if DEBUG
                _logger.LogDebug("Get cache size");
                #endif
                Response.Headers.Add("Content-Type", "application/json; charset=utf-8");
                Response.StatusCode = 200;
                var size = _jwtValidatorService.GetCacheSize();
                var result = Content($"{{\"X-Cache-Size\":\"{size}\"}}");
                return result;
            } catch (Exception e) {
                childSpan?.Finish(e);
                Response.Headers.Add("Content-Type", "application/json; charset=utf-8");
                Response.StatusCode = 500;
                _logger.LogError(e, "Error while getting cache size");
                return Content($"{{\"X-JWT-Error\":\"{e.Message}\"}}"); 
            }
        }
    }
}
