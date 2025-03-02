using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;

namespace MyFunctionApp
{
    public class Function1(ILogger<Function1> logger)
    {
        private readonly ILogger<Function1> _logger = logger;

        [Function("Function1")]
        public Task<IActionResult> Run([HttpTrigger(Microsoft.Azure.Functions.Worker.AuthorizationLevel.Function, "get", "post")] HttpRequest req)
        {
            var correlationId = "10506df2-f436-49a2-b11d-daa0fc1ceb26";
            _logger.LogInformation("C# HTTP trigger function processed a request. {correlationId}", correlationId);
            return Task.FromResult<IActionResult>(new OkObjectResult("Welcome to Azure Functions!"));
        }
    }
}
