using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Sentry.AspNetCore;

namespace JwtValidatorFirebase
{

    public class Program
    {

        private const string SentryDsn = "https://da9d8249787f47669d63700db044b472@o1186838.ingest.sentry.io/6307024";

        public static void Main(string[] args)
        {
            var builder = CreateHostBuilder(args);
            var app = builder.Build();
            app.Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                    webBuilder.UseSentry(Environment.GetEnvironmentVariable(SentryDsn))
                        .CaptureStartupErrors(true)
                        .ConfigureLogging((c, l) => {
                            l.AddConfiguration(c.Configuration);
                            l.ClearProviders();
                            l.AddConsole();
                            #if DEBUG
                            l.AddDebug();
                            #endif
                            l.AddSentry();
                        })
                        .UseStartup<Startup>()
                );

    }
}
