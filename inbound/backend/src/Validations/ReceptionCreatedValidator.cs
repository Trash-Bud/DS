using backend.Models;
using backend.Models.Kafka;

using FluentValidation;

namespace backend.Validations;

public class ReceptionCreatedValidator : AbstractValidator<ReceptionCreated>
{
    private readonly DatabaseContext _db;

    public ReceptionCreatedValidator(DatabaseContext db)
    {
        this._db = db;

        RuleFor(x => x.AsnId).Must(AsnExists).WithMessage("Asn does not exist");
    }

    private bool AsnExists(int? asnId)
    {
        if (this._db.ASNs == null)
            return false;

        return this._db.ASNs.Any(x => x.Id == asnId);
    }
}