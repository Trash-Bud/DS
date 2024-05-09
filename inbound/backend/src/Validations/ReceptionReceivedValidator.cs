using backend.Models;
using backend.Models.Kafka;

using FluentValidation;

namespace backend.Validations;

public class ReceptionReceivedValidator : AbstractValidator<ReceptionReceived>
{
    private readonly DatabaseContext _db;

    public ReceptionReceivedValidator(DatabaseContext db)
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