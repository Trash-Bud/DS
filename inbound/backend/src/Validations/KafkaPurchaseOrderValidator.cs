using backend.Models;
using backend.Models.Kafka;

using FluentValidation;

namespace backend.Validations;

public class KafkaPurchaseOrderValidator : AbstractValidator<KafkaPurchaseOrder>
{
    private readonly DatabaseContext _db;

    public KafkaPurchaseOrderValidator(DatabaseContext db)
    {
        this._db = db;

        RuleFor(x => x.Reference).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters")
            .Must(IsUniquePurchaseOrder).WithMessage("{PropertyName} already exists");

        RuleFor(x => x.Date).NotNull().WithMessage("{PropertyName} is required");

        RuleFor(x => x.BrandId).NotNull().WithMessage("{PropertyName} is required")
            .GreaterThanOrEqualTo(0).WithMessage("{PropertyName} must be greater than or equal to 0");

        RuleFor(x => x.Supplier).NotEmpty().WithMessage("{PropertyName} is required")
            .SetValidator(new SupplierValidator(db)!);
    }

    private bool IsUniquePurchaseOrder(string? purchaseOrderReference)
    {
        // TODO: check in database(?) if reference is unique
        return true;
    }
}