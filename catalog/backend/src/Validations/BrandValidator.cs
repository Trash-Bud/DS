using backend.Models;

using FluentValidation;

namespace backend.Validations;

public class BrandValidator : AbstractValidator<Brand>
{
    private readonly DatabaseContext _db;

    public BrandValidator(DatabaseContext context)
    {
        _db = context;

        RuleFor(brand => brand.Name)
            .NotEmpty()
            .WithMessage("{PropertyName} is required")
            .Must(IsUniqueName)
            .WithMessage("{PropertyName} must be unique")
            .MaximumLength(256)
            .WithMessage("{PropertyName} must be less than 256 characters");
    }

    private bool IsUniqueName(string? name)
    {
        return _db.Brands?.FirstOrDefault(brand => brand.Name == name) == null;
    }

}