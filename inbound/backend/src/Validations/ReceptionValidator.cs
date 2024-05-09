using backend.Models;
using backend.Models.Kafka;

using FluentValidation;

namespace backend.Validations;

public class ReceptionValidator : AbstractValidator<Reception>
{
    private readonly DatabaseContext _db;

    public ReceptionValidator(DatabaseContext db)
    {
        this._db = db;

        RuleFor(x => x.Reference).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters")
            .Must(IsUniqueReceptionReference).WithMessage("{PropertyName} already exists");

        RuleFor(x => x.Number).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");
        ;

        RuleFor(x => x.PlannedDeliveryDate).NotNull().WithMessage("{PropertyName} is required");

        RuleFor(x => x.WarehouseCode).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.Items).NotNull().WithMessage("{PropertyName} is required")
            .NotEmpty().WithMessage("{PropertyName} must have at least one item");

        RuleForEach(x => x.Items).SetValidator(new ItemValidator(db));
    }

    private bool IsUniqueReceptionReference(string? receptionReference)
    {
        // TODO: check in database(?) if receptionReference is unique
        return true;
    }
}