using System;
using System.Threading.Tasks;
using JwtValidatorFirebase.Interfaces;
using JwtValidatorFirebase.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace JwtValidatorFirebase.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class JwtValidatorController : ControllerBase
    {
        private readonly IJwtValidatorService _jwtValidatorService;
        private readonly ILogger<HealthCheckController> _logger;
        private readonly System.Text.Json.JsonSerializerOptions _jsonSerializerOptions;

        public JwtValidatorController(ILogger<HealthCheckController> logger, IJwtValidatorService jwtValidatorService)
        {
            _logger = logger;
            _jwtValidatorService = jwtValidatorService ?? throw new ArgumentNullException(nameof(jwtValidatorService));
            _jsonSerializerOptions = new System.Text.Json.JsonSerializerOptions
            {
                WriteIndented = false,
                DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingDefault
            };
        }

        [HttpGet]
        public async Task<IActionResult> GetValidationResult()
        {
            try
            {
                Response.Headers.Add("Content-Type", "application/json; charset=utf-8");
                Request.Headers.TryGetValue(JwtValidatorService.TokenHeaderName, out var jwtToken);
                var validatedResult = await _jwtValidatorService.ValidateIdTokenAsync(jwtToken);
                Response.StatusCode = validatedResult.IsValidated ? 200 : 401;
                return Content(
                    System.Text.Json.JsonSerializer.Serialize(
                        validatedResult,
                        _jsonSerializerOptions
                    )
                );
            }
            catch (Exception e)
            {
                Response.StatusCode = 401;
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
            Response.Headers.Add("Content-Type", "application/json; charset=utf-8");
            Response.StatusCode = 200;
            var size = _jwtValidatorService.GetCacheSize();
            return Content($"{{\"X-Cache-Size\":\"{size}\"}}");
        }
    }
}
