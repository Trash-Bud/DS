using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;
using System.Text.Json.Serialization;

namespace backend.Models;

[JsonConverter(typeof(JsonStringEnumMemberConverter))]
public enum PurchaseOrderState
{
    Open,
    [EnumMember(Value = "In Progress")]
    InProgress,
    Archived,
    Cancelled
}

public class PurchaseOrderDTO
{
    public String? PoIdentification { get; set; }
    public String? Name { get; set; }
    public String? Supplier { get; set; }
    public int? TotalItems { get; set; }
}

public class PurchaseOrder
{
    public PurchaseOrder()
    {
    }
    public PurchaseOrder(PurchaseOrderDTO dto)
    {
        PoIdentification = dto.PoIdentification;
        State = PurchaseOrderState.Open;
        Name = dto.Name;
        Supplier = dto.Supplier;
        ReceivedItems = 0;
        TotalItems = dto.TotalItems;
    }

    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    public String? PoIdentification { get; set; }

    public PurchaseOrderState? State { get; set; }

    public String? Name { get; set; }

    public String? Supplier { get; set; }

    public int ReceivedItems { get; set; }

    public int? TotalItems { get; set; }

    [Required]
    public ICollection<ASN> ASNs { get; set; } = new List<ASN>();
}