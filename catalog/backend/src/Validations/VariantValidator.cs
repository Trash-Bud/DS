using backend.Models;

using FluentValidation;

namespace backend.Validations;

public class VariantValidator : AbstractValidator<Variant>
{
    private readonly DatabaseContext _db;

    public VariantValidator(DatabaseContext context)
    {
        _db = context;

        RuleFor(variant => variant.ProductId)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .Must(IsValidProductId)
            .WithMessage("{PropertyName} must be a valid product");

        RuleFor(variant => variant.SKU)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(variant => variant.Barcode)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .MaximumLength(128)
            .WithMessage("{PropertyName} must be less than 128 characters");

        RuleFor(variant => variant.VariantDescription)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(variant => variant.Composition)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(variant => variant.Hscode)
            .NotEmpty()
            .Length(6, 15)
            .WithMessage("{PropertyName} must be between 6 and 15 characters");

        RuleFor(variant => variant.Country)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .Must(IsValidCountry)
            .WithMessage("{PropertyName} must be a valid country");


        RuleFor(variant => variant.Gender)
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(variant => variant.AgeGroup)
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(variant => variant.Color)
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(variant => variant.Size)
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(variant => variant.Fabric)
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(variant => variant.Width)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .GreaterThanOrEqualTo(0.00001)
            .WithMessage("{PropertyName} must be greater than {ComparisonValue}");

        RuleFor(variant => variant.Height)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .GreaterThanOrEqualTo(0.00001)
            .WithMessage("{PropertyName} must be greater than {ComparisonValue}");

        RuleFor(variant => variant.Depth)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .GreaterThanOrEqualTo(0.00001)
            .WithMessage("{PropertyName} must be greater than {ComparisonValue}");

        RuleFor(variant => variant.Weight)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .GreaterThanOrEqualTo(0.00001)
            .WithMessage("{PropertyName} must be greater than {ComparisonValue}");

        RuleFor(variant => variant.PriceRetail)
            .GreaterThanOrEqualTo(0)
            .WithMessage("{PropertyName} must be greater than {ComparisonValue}");

        RuleFor(variant => variant.PriceWholesale)
            .GreaterThanOrEqualTo(0)
            .WithMessage("{PropertyName} must be greater than {ComparisonValue}");

        RuleFor(variant => variant.Cost)
            .GreaterThanOrEqualTo(0)
            .WithMessage("{PropertyName} must be greater than {ComparisonValue}");

        RuleFor(variant => variant.Currency)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .Must(IsValidCurrency)
            .WithMessage("{PropertyName} must be a valid currency");

        RuleFor(variant => variant.Dangerous)
            .InclusiveBetween(1, 9)
            .WithMessage("{PropertyName} must be between {From} and {To}");

        RuleFor(variant => variant.UN)
            .InclusiveBetween(0, 9999999)
            .WithMessage("{PropertyName} must be between {From} and {To}");

        RuleFor(variant => variant.PackingCode)
            .InclusiveBetween(1, 3)
            .WithMessage("{PropertyName} must be between {From} and {To}");
    }

    private bool IsValidCountry(string? country)
    {
        return Array.BinarySearch(Constants.ValidCountries, country) >= 0;
    }

    private bool IsValidCurrency(string? currency)
    {
        return Array.BinarySearch(Constants.ValidCurrencies, currency) >= 0;
    }

    private bool IsValidProductId(int? productId)
    {
        return _db.Products?.Where(product => product.Id == productId).FirstOrDefault() != null;
    }
}