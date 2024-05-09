
using backend.Models;

using FluentValidation;

namespace backend.Validations;

public class ProductValidator : AbstractValidator<Product>
{
    public ProductValidator()
    {
        RuleFor(x => x.Name).NotNull().NotEmpty();
        RuleFor(x => x.Quantity).NotNull();
    }
}