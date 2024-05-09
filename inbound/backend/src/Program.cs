using System.Text.Json.Serialization;

using backend.Common;
using backend.Models;
using backend.Services;

using FluentValidation;

using Prometheus;

using promMetrics;

System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<DatabaseContext>();

// Add services to the container.
builder.Services.AddControllers().AddJsonOptions(
    x => x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles
);

// Add FluentValidation
// Scans the Assembly, find all the abstract validators and add them for us
builder.Services.AddValidatorsFromAssemblyContaining<IAssemblyMarker>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddHealthChecks();

builder.Services.AddCors(options =>
    options.AddPolicy("AllowAllOrigins",
        builder => builder.AllowAnyOrigin()
                          .AllowAnyMethod()
                          .AllowAnyHeader()));

builder.Services.AddHostedService<KafkaConsumerService>();

var app = builder.Build();

AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);

// log environment
app.Logger.LogInformation($"Environment: {app.Environment.EnvironmentName}");

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI(x => { x.SwaggerEndpoint("/swagger/v1/swagger.yaml", "Swagger API"); });


// app.UseHttpsRedirection();

app.UseCors("AllowAllOrigins");

app.UseMetricServer();
app.UseHttpMetrics();

app.ConfigureCustomExceptionMiddleware();

// Manual metrics
var manualMetrics = new PrometheusMetrics();
app.UseRouting();
app.UseAuthorization();
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
    endpoints.MapMetrics();
    manualMetrics.UpdateCpuMemMetrics();
    manualMetrics.IncrementRequestCounter();
});

app.MapHealthChecks("/healthz");

app.Run();

public partial class Program { }