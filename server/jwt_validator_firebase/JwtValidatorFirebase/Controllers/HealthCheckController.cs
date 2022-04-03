using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Sentry;
namespace JwtValidatorFirebase.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HealthCheckController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<HealthCheckController> _logger;
        private readonly IHub _sentryHub;

        public HealthCheckController(ILogger<HealthCheckController> logger, IHub sentryHub)
        {
            _logger = logger;
            _sentryHub = sentryHub;
        }

        [HttpGet]
        public IActionResult Get()
        {
            try {
                #if DEBUG
                _logger.LogDebug("Health check");
                #endif
                var rng = new Random();
                return Ok(Summaries[rng.Next(Summaries.Length)]);
            } catch (Exception e) {
                _sentryHub.CaptureException(e);
                _logger.LogError(e, "Error occurred while health check");
                return StatusCode(500, e.Message);
            }
        }
    }
}
