using backend.Models;
using backend.Models.Kafka;

using FluentValidation;

namespace backend.Validations;

public class SupplierValidator : AbstractValidator<Supplier>
{
    private readonly DatabaseContext _db;

    public SupplierValidator(DatabaseContext db)
    {
        this._db = db;

        RuleFor(x => x.Name).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.Email).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.Phone).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256)
            .WithMessage(
                "{PropertyName} must be between 1 and 256 characters"); // Missing phone format, so the maximum number of digits is also missing. default: 256

        RuleFor(x => x.ContactPerson).MaximumLength(256)
            .WithMessage("{PropertyName} must have at a maximum 256 characters");

        RuleFor(x => x.TaxNumber).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.Address).NotNull().WithMessage("{PropertyName} is required")
            .SetValidator(new KafkaAddressValidator(db)!);
    }
}