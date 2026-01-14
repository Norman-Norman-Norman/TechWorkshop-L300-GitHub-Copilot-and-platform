using Azure;
using Azure.AI.Inference;
using Azure.Core;
using ZavaStorefront.Models;

namespace ZavaStorefront.Services
{
    public class FoundryService
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<FoundryService> _logger;

        public FoundryService(IConfiguration configuration, ILogger<FoundryService> logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        public async Task<string> SendMessageAsync(string userMessage)
        {
            try
            {
                var endpoint = _configuration["Foundry:Endpoint"];
                var apiKey = _configuration["Foundry:ApiKey"];
                var modelName = _configuration["Foundry:ModelName"] ?? "Phi-4";

                if (string.IsNullOrEmpty(endpoint) || string.IsNullOrEmpty(apiKey))
                {
                    _logger.LogWarning("Foundry configuration is missing. Please configure Endpoint and ApiKey.");
                    return "Error: Foundry configuration is not set. Please configure the endpoint and API key in appsettings.json or user secrets.";
                }

                var credential = new AzureKeyCredential(apiKey);
                var client = new ChatCompletionsClient(new Uri(endpoint), credential);

                var requestOptions = new ChatCompletionsOptions()
                {
                    Messages =
                    {
                        new ChatRequestSystemMessage("You are a helpful AI assistant."),
                        new ChatRequestUserMessage(userMessage)
                    },
                    Model = modelName,
                    MaxTokens = 1000,
                    Temperature = 0.7f
                };

                _logger.LogInformation("Sending message to Foundry endpoint: {Endpoint}", endpoint);

                var response = await client.CompleteAsync(requestOptions);
                var result = response.Value;

                if (result.Content != null && !string.IsNullOrEmpty(result.Content))
                {
                    _logger.LogInformation("Received response from Foundry");
                    return result.Content;
                }

                _logger.LogWarning("No response content returned from Foundry");
                return "Error: No response received from the AI model.";
            }
            catch (RequestFailedException ex)
            {
                _logger.LogError(ex, "Foundry API request failed: {Message}", ex.Message);
                return $"Error: API request failed - {ex.Message}";
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error calling Foundry API: {Message}", ex.Message);
                return $"Error: {ex.Message}";
            }
        }
    }
}
