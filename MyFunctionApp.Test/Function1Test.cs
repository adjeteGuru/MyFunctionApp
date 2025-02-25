using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;

namespace MyFunctionApp.Test
{
    public class Function1Test
    {
        [Fact]
        public void Run_WhenCalled_AssertTheCorrectType()
        {
            var function = new Function1(new Mock<ILogger<Function1>>().Object);
            var result = function.Run(new Mock<HttpRequest>().Object);
            Assert.IsType<OkObjectResult>(result);
        }

        [Fact]
        public void Run_WhenCalled_Trigger()
        {
            var function = new Function1(new Mock<ILogger<Function1>>().Object);
            var result = function.Run(new Mock<HttpRequest>().Object);
            var resultObject = (OkObjectResult)result;

            Assert.Equal("Welcome to Azure Functions!", resultObject.Value);
        }
    }
}