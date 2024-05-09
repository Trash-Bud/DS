using System.Globalization;

using Confluent.Kafka;

namespace kafka;

public class KafkaConfig
{
    public KafkaConfig()
    {
        var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.local.json", optional: true)
            .Build();

        NumPartitions = Int32.Parse(configuration.GetSection("Kafka:partitions").Value ?? "1");
        ReplicationFactor = Int16.Parse(configuration.GetSection("Kafka:replicationFactor").Value ?? "1");
        GroupId = configuration.GetSection("Kafka:group").Value ?? "inbound";
        Servers = configuration.GetSection("Kafka:servers").Value ?? "kafka:9092";
        TimeoutVal = Int32.Parse(configuration.GetSection("Kafka:timeout").Value ?? "10000");
        SaslUsername = configuration.GetSection("Kafka:username").Value ?? "";
        SaslPassword = configuration.GetSection("Kafka:password").Value ?? "";
        Protocol = SaslUsername != "" ? SecurityProtocol.SaslSsl : SecurityProtocol.Plaintext;
        Prefix = configuration.GetSection("Kafka:prefix").Value ?? "";
    }

    public string Prefix { get; set; }

    public SecurityProtocol Protocol { get; set; }

    public string SaslPassword { get; set; }

    public string SaslUsername { get; set; }

    public string GroupId { get; set; }

    public int TimeoutVal { get; set; }

    public string Servers { get; set; }

    public short ReplicationFactor { get; set; }

    public int NumPartitions { get; set; }
}