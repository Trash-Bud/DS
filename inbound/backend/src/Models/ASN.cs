using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;
using System.Text.Json.Serialization;

using backend.Models.Kafka;

namespace backend.Models;

[JsonConverter(typeof(JsonStringEnumMemberConverter))]
public enum ASNState
{
    Pending,
    Booked,
    Received,
    Cancelled
}

[JsonConverter(typeof(JsonStringEnumMemberConverter))]
public enum CargoType
{
    Normal,
    Dangerous
}

public class ASNCreateDTO
{
    [Required]
    public String? ShipmentReference { get; set; }

    [Required]
    public String? Warehouse { get; set; }

    [Required]
    public DateTime? ExpectedDeliveryDate { get; set; }

    [ForeignKey("PurchaseOrder")]
    public int? PurchaseOrderId { get; set; }
}

public class ASNEditDTO
{
    [Required]
    public String? ShipmentReference { get; set; }

    [Required]
    public String? Warehouse { get; set; }

    public DateTime? ExpectedDeliveryDate { get; set; }

    public String? ShipperContact { get; set; } = "";

    public String? Address { get; set; } = "";

    public String? CarrierName { get; set; } = "";

    [ForeignKey("PurchaseOrder")]
    public int? PurchaseOrderId { get; set; }
}

public class ASN
{

    public ASN() { }

    public ASN(ASNCreateDTO dto)
    {
        ShipmentReference = dto.ShipmentReference;
        Warehouse = dto.Warehouse;
        ExpectedDeliveryDate = dto.ExpectedDeliveryDate;
        if (dto.PurchaseOrderId != null)
            PurchaseOrderId = dto.PurchaseOrderId;
    }

    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    // TODO: Setup FluentValidation and validate if this is unique
    [Required]
    [MaxLength(256)]
    public String? ShipmentReference { get; set; }

    [Required]
    [EnumDataType(typeof(ASNState), ErrorMessage = "Invalid ASN state")]
    public ASNState State { get; set; } = ASNState.Pending;

    [MaxLength(256)]
    public String? Address { get; set; } = "";

    [Required]
    [MaxLength(256)]
    public String? Warehouse { get; set; }

    [Required]
    public DateTime? ExpectedDeliveryDate { get; set; }

    [MaxLength(256)]
    public String? CarrierName { get; set; } = "";

    public CargoType Type { get; set; } = CargoType.Normal;

    [MaxLength(256)]
    public String? ShipperContact { get; set; } = "";

    [ForeignKey("PurchaseOrder")]
    public int? PurchaseOrderId { get; set; }

    [JsonIgnore]
    public PurchaseOrder? PurchaseOrder { get; set; }

    public DateTime? PurchaseOrderDate { get; set; }

    public ICollection<Product> ProductList { get; set; } = new List<Product>();

    [ForeignKey("ReceptionCreated")]
    public int? ReceptionCreatedId { get; set; }

    [JsonIgnore]
    public ReceptionCreated? ReceptionCreated { get; set; }

    [ForeignKey("ReceptionReceived")]
    public int? ReceptionReceivedId { get; set; }

    [JsonIgnore]
    public ReceptionReceived? ReceptionReceived { get; set; }
}