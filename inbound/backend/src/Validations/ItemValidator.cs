using backend.Models;
using backend.Models.Kafka;

using FluentValidation;

namespace backend.Validations;

public class ItemValidator : AbstractValidator<Item>
{
    private readonly DatabaseContext _db;

    public ItemValidator(DatabaseContext db)
    {
        this._db = db;

        RuleFor(x => x.Reference).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters")
            .Must(ItemReferenceExists).WithMessage("{PropertyName} already exists");

        RuleFor(x => x.Ean).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.ExpectedQuantity).NotNull().WithMessage("{PropertyName} is required")
            .GreaterThanOrEqualTo(1).WithMessage("{PropertyName} must be greater than or equal to 1");
    }

    private bool ItemReferenceExists(string? itemReference)
    {
        // TODO: check in database(?) if there is a matching itemReference
        return true;
    }
}