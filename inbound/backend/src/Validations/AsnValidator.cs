using backend.Models;

using FluentValidation;

namespace backend.Validations;

public class AsnValidator : AbstractValidator<ASN>
{
    private readonly DatabaseContext _db;

    public AsnValidator(DatabaseContext db)
    {
        this._db = db;
        RuleFor(x => x.ShipmentReference).NotEmpty().WithMessage("Shipment Reference is required")
            .Must(IsUniqueASN).WithMessage("Shipment Reference already exists");

        RuleFor(x => x.State).NotNull().WithMessage("{PropertyName} is required");


        RuleFor(x => x.Address).MaximumLength(256).WithMessage("{PropertyName} must not exceed 256 characters");
        RuleFor(x => x.Warehouse).NotNull().WithMessage("{PropertyName} is required")
            .MaximumLength(256).WithMessage("{PropertyName} must not exceed 256 characters");

        RuleFor(x => x.ShipperContact).MaximumLength(256).WithMessage("{PropertyName} must not exceed 256 characters");
        RuleFor(x => x.PurchaseOrderId).Must(purchaseOrderExistsOrNull).WithMessage("Purchase Order does not exist");

        RuleFor(x => x.ProductList).NotNull().WithMessage("Product List is required");
        RuleForEach(x => x.ProductList).SetValidator(new ProductValidator());
    }

    private bool IsUniqueASN(string? asnIdentification)
    {
        if (this._db.ASNs == null)
            return false;

        return !this._db.ASNs.Any(x => x.ShipmentReference == asnIdentification);
    }

    private bool purchaseOrderExistsOrNull(int? purchaseOrderId)
    {

        if (purchaseOrderId == null)
        {
            return true;
        }

        if (this._db.PurchaseOrders == null)
            return false;

        return this._db.PurchaseOrders.Any(x => x.Id == purchaseOrderId);
    }
}