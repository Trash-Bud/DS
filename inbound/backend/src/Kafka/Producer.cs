using Confluent.Kafka;

using kafka;

using Newtonsoft.Json;

namespace backend.Kafka;

internal class Producer<T>
{
    private readonly string _topicName;
    private readonly KafkaConfig _kafkaConfig;

    public Producer(string topicName, KafkaConfig kafkaConfig)
    {
        this._topicName = topicName;
        this._kafkaConfig = kafkaConfig;
    }

    /// <summary>
    /// Creates a Producer and sends a message to a topic.
    /// If topic doesn't exist, creates it.
    /// </summary>
    /// <param name="message">message object to be sent</param>
    public void Send(T message)
    {
        var config = new ProducerConfig
        {
            BootstrapServers = this._kafkaConfig.Servers,
            SecurityProtocol = this._kafkaConfig.Protocol,
            SaslUsername = this._kafkaConfig.SaslUsername,
            SaslPassword = this._kafkaConfig.SaslPassword,
            SaslMechanism = SaslMechanism.Plain,
            SslCaLocation = "/etc/ssl/certs"
        };
        using var producer = new ProducerBuilder<Null, string>(config).Build();

        string serialized = JsonConvert.SerializeObject(message);

        producer.Produce(this._topicName,
            new Message<Null, string>
            {
                Value = serialized,
            }, (response) =>
            {
                if (response.Error.Code != ErrorCode.NoError)
                {
                    throw new Exception($"[KAFKA]: Failed to deliver message: {response.Error.Reason}");
                }
            });

        CancellationToken cancellationToken = new CancellationTokenSource(this._kafkaConfig.TimeoutVal).Token;

        producer.Flush(cancellationToken);
    }
}