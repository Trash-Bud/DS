using backend.Common;
using backend.Models;

using FluentValidation;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<DatabaseContext>();

// Add services to the container.
builder.Services.AddControllers();

// Add FluentValidation
// Scans the Assembly, find all the abstract validators and add them for us
builder.Services.AddValidatorsFromAssemblyContaining<IAssemblyMarker>();

builder.Services.AddHealthChecks();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddHealthChecks();

builder.Services.AddCors(options =>
    options.AddPolicy("AllowAllOrigins",
        builder => builder.AllowAnyOrigin()
                          .AllowAnyMethod()
                          .AllowAnyHeader()));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(x => { x.SwaggerEndpoint("/swagger/v1/swagger.yaml", "Swagger API"); });
}

app.UseAuthorization();

app.UseCors("AllowAllOrigins");

app.MapControllers();

builder.Services.AddHealthChecks();

app.Run();

public partial class Program { }