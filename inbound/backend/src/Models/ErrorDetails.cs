using System.Text.Json;
using System.Text.Json.Serialization;

namespace backend.Models;

public class ErrorDetails
{
    [JsonPropertyName("status")]
    public int StatusCode { get; set; }

    [JsonPropertyName("error")]
    public string? Message { get; set; }

    public override string ToString()
    {
        return JsonSerializer.Serialize(this);
    }
}