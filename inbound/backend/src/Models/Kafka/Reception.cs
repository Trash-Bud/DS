using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace backend.Models.Kafka;

public class Reception
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [MaxLength(256)]
    [JsonPropertyName("reference")]
    public string? Reference { get; set; }

    [Required]
    [MaxLength(256)]
    [JsonPropertyName("number")]
    public string? Number { get; set; }

    [Required]
    [JsonPropertyName("planned_delivery_date")]
    public DateTime? PlannedDeliveryDate { get; set; }

    [Required]
    [MaxLength(256)]
    [JsonPropertyName("warehouse_code")]
    public string? WarehouseCode { get; set; }

    [Required]
    [JsonPropertyName("items")]
    public List<Item>? Items { get; set; }
}