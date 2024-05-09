using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace backend.Models.Kafka;

public class ReceptionCreated
{
    public ReceptionCreated() { }

    public ReceptionCreated(int asnId)
    {
        AsnId = asnId;
    }

    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [ForeignKey("Asn")]
    public int? AsnId { get; set; }

    [Required]
    [JsonPropertyName("asn")]
    public ASN? Asn { get; set; }

}