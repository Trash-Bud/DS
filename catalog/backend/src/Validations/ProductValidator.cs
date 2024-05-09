using backend.Models;

using FluentValidation;

namespace backend.Validations;

public class ProductValidator : AbstractValidator<Product>
{
    private readonly DatabaseContext _db;

    public ProductValidator(DatabaseContext context)
    {
        _db = context;

        RuleFor(product => product.BrandId)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .Must(brandId => _db.Brands!.Any(brand => brand.Id == brandId))
            .WithMessage("{PropertyName} must be a valid brand");

        RuleFor(product => product.Name)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(product => product.Description)
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(product => product.Season)
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(product => product.Supplier)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(product => product.Type)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(product => product.Family)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");

        RuleFor(product => product.SubFamily)
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");
    }
}