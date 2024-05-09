using System.Net;

using backend.Models;

namespace backend.Middleware;

public class ExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger _logger;

    public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
    {
        _logger = logger;
        _next = next;
    }
    public async Task InvokeAsync(HttpContext httpContext)
    {
        try
        {
            await _next(httpContext);
        }
        catch (Exception ex) { await HandleUnexpectedException(httpContext, ex); }
    }

    private async Task HandleUnexpectedException(HttpContext context, Exception exception)
    {
        context.Response.ContentType = "application/json";

        var errorDetails = exception switch
        {
            KeyNotFoundException notFoundException => GetNotFoundErrorDetails(notFoundException),
            InvalidDataException invalidDataException => GetUnprocessableEntityDetails(invalidDataException),
            InvalidOperationException invalidOperationException => GetUnprocessableEntityDetails(invalidOperationException),
            _ => GetUnexpectedErrorDetails(exception)
        };

        context.Response.StatusCode = errorDetails.StatusCode;
        await context.Response.WriteAsync(errorDetails.ToString());
    }

    private ErrorDetails GetNotFoundErrorDetails(Exception exception)
    {
        return new ErrorDetails()
        {
            StatusCode = StatusCodes.Status404NotFound,
            Message = exception.Message
        };
    }

    private ErrorDetails GetUnprocessableEntityDetails(Exception exception)
    {
        return new ErrorDetails()
        {
            StatusCode = StatusCodes.Status422UnprocessableEntity,
            Message = exception.Message
        };
    }

    private ErrorDetails GetUnexpectedErrorDetails(Exception exception)
    {
        _logger.LogError($"Unexpected error: {exception}");
        return new ErrorDetails()
        {
            StatusCode = StatusCodes.Status500InternalServerError,
            Message = "Unexpected Error"
        };
    }
}