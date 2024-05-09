using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace backend.Common;

using FluentValidation;
using FluentValidation.Results;

public class RoutesUtils : ControllerBase
{
    public static ModelStateDictionary? Validate<T>(IValidator<T> validator, T model)
    {
        ValidationResult validationResult = validator.Validate(model);
        if (validationResult.IsValid) return null;

        var modelStateDict = new ModelStateDictionary();
        foreach (ValidationFailure fail in validationResult.Errors)
        {
            modelStateDict.AddModelError(fail.PropertyName, fail.ErrorMessage);
        }
        return modelStateDict;
    }
}