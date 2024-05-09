using backend.Models;
using backend.Models.Kafka;

using FluentValidation;

namespace backend.Validations;

public class KafkaAddressValidator : AbstractValidator<KafkaAddress>
{
    private readonly DatabaseContext _db;

    public KafkaAddressValidator(DatabaseContext db)
    {
        this._db = db;

        RuleFor(x => x.Address).NotEmpty().WithMessage("{PropertyName} is required");

        RuleFor(x => x.Zip).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.City).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.Country).NotNull().WithMessage("{PropertyName} is required")
            .Length(2).WithMessage("{PropertyName} must be exactly 2 characters");
    }
}