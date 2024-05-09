using backend.Models;

namespace backend.Kafka.Handlers;

public abstract class KafkaHandler<T>
{
    protected readonly IServiceProvider _serviceProvider;

    protected KafkaHandler(IServiceProvider serviceProvider)
    {
        this._serviceProvider = serviceProvider;
    }

    public abstract void Handle(T message);
}