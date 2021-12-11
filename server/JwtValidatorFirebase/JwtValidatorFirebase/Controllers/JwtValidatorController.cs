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

        public JwtValidatorController(ILogger<HealthCheckController> logger, IJwtValidatorService jwtValidatorService)
        {
            _logger = logger;
            _jwtValidatorService = jwtValidatorService ?? throw new ArgumentNullException(nameof(jwtValidatorService));
        }

        [HttpGet]
        public async Task<IActionResult> GetValidationResult()
        {
            Request.Headers.TryGetValue(JwtValidatorService.TokenHeaderName, out var jwtToken);
            var validatedResult = await _jwtValidatorService.ValidateIdTokenAsync(jwtToken);
            if (validatedResult.IsValidated)
                return Ok(validatedResult);
            else
                return Unauthorized();
        }

        [HttpGet("generate/{uid}")]
        public async Task<IActionResult> GetCustomToken(string uid)
        {
            var token = await _jwtValidatorService.GenerateCustomTokenAsync(uid);
            return Ok(token);
        }

        [HttpGet("cache-size")]
        public IActionResult GetCacheSize()
        {
            var size = _jwtValidatorService.GetCacheSize();
            return Ok(size);
        }
    }
}
