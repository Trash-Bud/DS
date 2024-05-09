using backend.Controllers;
using backend.Kafka;
using backend.Kafka.Handlers;
using backend.Models;
using backend.Models.Kafka;

using kafka;

using Microsoft.EntityFrameworkCore;

namespace backend.Services;

public class KafkaConsumerService : BackgroundService
{
    private readonly ILogger<KafkaConsumerService> _logger;
    private readonly IServiceProvider _serviceProvider;
    private readonly KafkaConfig _kafkaConfig;

    public KafkaConsumerService(IServiceProvider serviceProvider, ILogger<KafkaConsumerService> logger)
    {
        this._logger = logger;
        this._serviceProvider = serviceProvider;
        this._kafkaConfig = new KafkaConfig();
    }

    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        KafkaHealthHandler kafkaHealthHandler = new(this._serviceProvider);
        ReceptionCreatedHandler receptionCreatedHandler = new(this._serviceProvider);
        ReceptionReceivedHandler receptionReceivedHandler = new(this._serviceProvider);

        Consumer<KafkaHealthCheck> healthCheckConsumer = new(kafkaHealthHandler, _kafkaConfig.Prefix + TopicsNames.HealthCheck, _kafkaConfig);
        Consumer<ReceptionCreated> receptionCreatedConsumer = new(receptionCreatedHandler, _kafkaConfig.Prefix + TopicsNames.ReceptionCreated, _kafkaConfig);
        Consumer<ReceptionReceived> receptionReceivedConsumer = new(receptionReceivedHandler, _kafkaConfig.Prefix + TopicsNames.ReceptionReceived, _kafkaConfig);
        try
        {
            healthCheckConsumer.StartConsumer(stoppingToken);
            receptionCreatedConsumer.StartConsumer(stoppingToken);
            receptionReceivedConsumer.StartConsumer(stoppingToken);
        }
        catch (Exception e)
        {
            this._logger.LogError(e.Message);
        }

        return Task.CompletedTask;
    }
}