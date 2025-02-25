using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;

namespace MyFunctionApp.Test
{
    public class Function1Test
    {
        [Fact]
        public async Task Run_WhenCalled_LogsMessage()
        {
            var loggerMock = new Mock<ILogger<Function1>>();
            var function = new Function1(loggerMock.Object);
            Func<Task> func = async () => await function.Run(new Mock<HttpRequest>().Object);
        }

        [Fact]
        public async Task Run_WhenCalled_AssertTheCorrectType()
        {
            var function = new Function1(new Mock<ILogger<Function1>>().Object);
            var result = await function.Run(new Mock<HttpRequest>().Object);
            Assert.IsType<OkObjectResult>(result);
        }

        [Fact]
        public async Task Run_WhenCalled_Trigger()
        {
            var function = new Function1(new Mock<ILogger<Function1>>().Object);
            var result = await function.Run(new Mock<HttpRequest>().Object);
            var resultObject = (OkObjectResult)result;

            Assert.Equal("Welcome to Azure Functions!", resultObject.Value);
        }
    }
}