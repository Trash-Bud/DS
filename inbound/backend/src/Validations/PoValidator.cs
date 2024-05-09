using backend.Models;

using FluentValidation;

namespace backend.Validations;

public class PoValidator : AbstractValidator<PurchaseOrder>
{
    private readonly DatabaseContext _db;

    public PoValidator(DatabaseContext db)
    {
        this._db = db;
        RuleFor(x => x.PoIdentification).NotEmpty().WithMessage("{PropertyName} is required")
            .Must(IsUniquePo).WithMessage("A PO with that {PropertyName} already exists");

        RuleFor(x => x.State).NotNull().WithMessage("{PropertyName} is required");

        /*
         TODO: Check how to customize the Error message in case of an invalid enum
        .IsInEnum().WithMessage("Invalid PurchaseOrder state"); 
        https://github.com/FluentValidation/FluentValidation/issues/381
        */

        RuleFor(x => x.Name).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.Supplier).NotEmpty().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must be between 1 and 256 characters");

        RuleFor(x => x.ReceivedItems).NotNull().WithMessage("{PropertyName} is required")
            .InclusiveBetween(0, Int32.MaxValue).WithMessage("{PropertyName} must be a positive integer");

        RuleFor(x => x.TotalItems).NotNull().WithMessage("{PropertyName} is required")
            .InclusiveBetween(0, Int32.MaxValue).WithMessage("{PropertyName} must be a positive integer");
    }

    private bool IsUniquePo(string? poIdentification)
    {
        if (this._db.PurchaseOrders == null)
            return false;

        return !this._db.PurchaseOrders.Any(x => x.PoIdentification == poIdentification);
    }
}