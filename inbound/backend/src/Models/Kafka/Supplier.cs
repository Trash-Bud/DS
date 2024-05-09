using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace backend.Models.Kafka;

public class Supplier
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [JsonPropertyName("name")]
    public string? Name { get; set; }

    [Required]
    [JsonPropertyName("email")]
    public string? Email { get; set; }

    [Required]
    [JsonPropertyName("phone")]
    public string? Phone { get; set; }

    [JsonPropertyName("contact_person")]
    public string? ContactPerson { get; set; }

    [Required]
    [JsonPropertyName("tax_number")]
    public string? TaxNumber { get; set; }

    [Required]
    [JsonPropertyName("address")]
    public KafkaAddress? Address { get; set; }
}