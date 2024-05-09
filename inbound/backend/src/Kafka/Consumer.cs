using System.Runtime.CompilerServices;

using backend.Kafka.Handlers;
using backend.Models;
using backend.Services;

using Confluent.Kafka;
using Confluent.Kafka.Admin;

using kafka;

using Newtonsoft.Json;

namespace backend.Kafka;

internal class Consumer<T>
{
    private readonly KafkaHandler<T> _handler;
    private readonly string _topic;
    private readonly KafkaConfig _kafkaConfig;
    private bool _running = false;

    public Consumer(KafkaHandler<T> handler, string topicName, KafkaConfig kafkaConfig)
    {
        this._handler = handler;
        this._topic = topicName;
        this._kafkaConfig = kafkaConfig;
    }

    private void CreateTopicIfNotExists()
    {
        var config = new ClientConfig()
        {
            BootstrapServers = _kafkaConfig.Servers,
            SecurityProtocol = _kafkaConfig.Protocol,
            SaslUsername = _kafkaConfig.SaslUsername,
            SaslPassword = _kafkaConfig.SaslPassword,
            SaslMechanism = SaslMechanism.Plain,
            SslCaLocation = "/etc/ssl/certs"
        };
        using var adminClient = new AdminClientBuilder(config).Build();
        var metadata = adminClient.GetMetadata(TimeSpan.FromSeconds(10));
        var topicsMetadata = metadata.Topics;
        var topicNames = topicsMetadata.Find(a => a.Topic == this._topic);

        if (topicNames != null)
        {
            return;
        }

        var specification = new TopicSpecification
        {
            Name = this._topic,
            ReplicationFactor = this._kafkaConfig.ReplicationFactor,
            NumPartitions = this._kafkaConfig.NumPartitions,
        };

        var topicSpecs = new List<TopicSpecification> { specification };

        var token = new CancellationTokenSource(this._kafkaConfig.TimeoutVal).Token;
        adminClient.CreateTopicsAsync(topicSpecs).Wait(token);

    }


    /// <summary>
    /// Creates a consumer to a topic. If topic does not exist, creates it.
    /// Subscribes to the refered topic and then consumes messages of it.
    /// </summary>
    /// <param name="cancellationToken">cancellation token regarding the background service</param>
    public async void StartConsumer(CancellationToken cancellationToken)
    {
        this.CreateTopicIfNotExists();

        var config = new ConsumerConfig
        {
            GroupId = this._kafkaConfig.GroupId,
            BootstrapServers = this._kafkaConfig.Servers,
            SecurityProtocol = this._kafkaConfig.Protocol,
            SaslUsername = this._kafkaConfig.SaslUsername,
            SaslPassword = this._kafkaConfig.SaslPassword,
            SaslMechanism = SaslMechanism.Plain,
            SslCaLocation = "/etc/ssl/certs"
        };

        using var consumer = new ConsumerBuilder<Null, string>(config).Build();
        consumer.Subscribe(this._topic);

        this._running = true;

        var token = new CancellationTokenSource().Token;

        await Task.Yield();

        while (!cancellationToken.IsCancellationRequested && this._running)
        {
            var response = consumer.Consume(token);
            if (response.Message != null)
            {
                T? result = JsonConvert.DeserializeObject<T>(response.Message.Value);

                if (result == null)
                {
                    throw new Exception($"Invalid message received in {typeof(T)}");
                }

                _handler.Handle(result);
            }
        }
    }

    public void StopConsuming()
    {
        this._running = false;
    }
}