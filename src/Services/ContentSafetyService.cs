// Task 06.03: Azure AI Content Safety Service
// Evaluates user prompts for unsafe content before sending to the AI model
using Azure;
using Azure.AI.ContentSafety;
using Azure.Identity;

namespace ZavaStorefront.Services
{
    /// <summary>
    /// Result of content safety evaluation
    /// </summary>
    public class ContentSafetyResult
    {
        public bool IsSafe { get; set; }
        public string? BlockedCategory { get; set; }
        public int? Severity { get; set; }
        public string? Message { get; set; }
    }

    /// <summary>
    /// Service for evaluating content safety using Azure AI Content Safety
    /// </summary>
    public class ContentSafetyService
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<ContentSafetyService> _logger;
        private readonly ContentSafetyClient? _client;
        private readonly bool _isEnabled;

        // Severity threshold - anything >= 2 is considered unsafe
        private const int UNSAFE_SEVERITY_THRESHOLD = 2;

        public ContentSafetyService(IConfiguration configuration, ILogger<ContentSafetyService> logger)
        {
            _configuration = configuration;
            _logger = logger;

            var endpoint = _configuration["ContentSafety:Endpoint"];
            var apiKey = _configuration["ContentSafety:ApiKey"];

            if (!string.IsNullOrEmpty(endpoint))
            {
                try
                {
                    // Use API key if provided, otherwise use DefaultAzureCredential (managed identity/CLI)
                    if (!string.IsNullOrEmpty(apiKey))
                    {
                        _client = new ContentSafetyClient(new Uri(endpoint), new AzureKeyCredential(apiKey));
                        _logger.LogInformation("ContentSafety: Service initialized with API key");
                    }
                    else
                    {
                        // Use DefaultAzureCredential for managed identity or Azure CLI auth
                        _client = new ContentSafetyClient(new Uri(endpoint), new DefaultAzureCredential());
                        _logger.LogInformation("ContentSafety: Service initialized with DefaultAzureCredential");
                    }
                    _isEnabled = true;
                    _logger.LogInformation("ContentSafety: Endpoint configured: {Endpoint}", endpoint);
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "ContentSafety: Failed to initialize client");
                    _isEnabled = false;
                }
            }
            else
            {
                _logger.LogWarning("ContentSafety: Service not configured. Content safety checks will be skipped.");
                _isEnabled = false;
            }
        }

        /// <summary>
        /// Evaluates user input for unsafe content
        /// </summary>
        /// <param name="userMessage">The user's message to evaluate</param>
        /// <returns>ContentSafetyResult indicating if content is safe</returns>
        public async Task<ContentSafetyResult> EvaluateContentAsync(string userMessage)
        {
            // If service is not enabled, allow all content (log warning)
            if (!_isEnabled || _client == null)
            {
                _logger.LogWarning("ContentSafety: Service not enabled, skipping safety check");
                return new ContentSafetyResult { IsSafe = true, Message = "Content safety check skipped (service not configured)" };
            }

            try
            {
                _logger.LogInformation("ContentSafety: Evaluating message for safety");

                var request = new AnalyzeTextOptions(userMessage);
                var response = await _client.AnalyzeTextAsync(request);

                // Check each category for unsafe content
                var categoriesAnalysis = response.Value.CategoriesAnalysis;
                
                foreach (var category in categoriesAnalysis)
                {
                    var categoryName = category.Category.ToString();
                    var severity = category.Severity ?? 0;

                    _logger.LogInformation("ContentSafety: Category={Category}, Severity={Severity}", 
                        categoryName, severity);

                    // If severity >= threshold, content is unsafe
                    if (severity >= UNSAFE_SEVERITY_THRESHOLD)
                    {
                        _logger.LogWarning("ContentSafety: BLOCKED - Category={Category}, Severity={Severity}", 
                            categoryName, severity);

                        return new ContentSafetyResult
                        {
                            IsSafe = false,
                            BlockedCategory = categoryName,
                            Severity = severity,
                            Message = $"Your message was blocked due to potentially unsafe content ({categoryName}). Please rephrase your request."
                        };
                    }
                }

                _logger.LogInformation("ContentSafety: Message passed safety check");
                return new ContentSafetyResult { IsSafe = true, Message = "Content is safe" };
            }
            catch (RequestFailedException ex)
            {
                _logger.LogError(ex, "ContentSafety: API request failed - {Message}", ex.Message);
                // On API failure, we could either block (fail-safe) or allow (fail-open)
                // Here we fail-open but log the error
                return new ContentSafetyResult 
                { 
                    IsSafe = true, 
                    Message = $"Content safety check failed: {ex.Message}" 
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "ContentSafety: Unexpected error - {Message}", ex.Message);
                return new ContentSafetyResult 
                { 
                    IsSafe = true, 
                    Message = $"Content safety check error: {ex.Message}" 
                };
            }
        }
    }
}
