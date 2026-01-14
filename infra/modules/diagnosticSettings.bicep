// Diagnostic Settings module
// Task 06.02: Enable diagnostic logs for AI Foundry/Microsoft Foundry

@description('Name of the AI Foundry Hub')
param aiFoundryHubName string

@description('Log Analytics Workspace ID')
param logAnalyticsWorkspaceId string

// Reference the existing AI Foundry Hub
resource aiFoundryHub 'Microsoft.MachineLearningServices/workspaces@2024-04-01' existing = {
  name: aiFoundryHubName
}

// Enable diagnostic settings to send logs to Log Analytics
resource diagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'ai-foundry-diagnostics'
  scope: aiFoundryHub
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        categoryGroup: 'allLogs'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
  }
}

output diagnosticSettingId string = diagnosticSetting.id
