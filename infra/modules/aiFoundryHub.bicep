// AI Foundry Hub (Microsoft.MachineLearningServices/workspaces with kind='Hub')
// Task 06.01: Configured with disableLocalAuth to enforce identity-only access

@description('Name of the AI Foundry Hub')
param name string

@description('Location for the resource')
param location string

@description('Storage Account ID')
param storageAccountId string

@description('Key Vault ID')
param keyVaultId string

@description('Application Insights ID')
param appInsightsId string

@description('Container Registry ID')
param containerRegistryId string

@description('Disable local/key-based authentication (enforce identity-only)')
param disableLocalAuth bool = true

resource aiFoundryHub 'Microsoft.MachineLearningServices/workspaces@2024-04-01' = {
  name: name
  location: location
  kind: 'Hub'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    friendlyName: 'Zava Storefront AI Hub'
    description: 'AI Foundry Hub for Zava Storefront application'
    storageAccount: storageAccountId
    keyVault: keyVaultId
    applicationInsights: appInsightsId
    containerRegistry: containerRegistryId
    // Task 06.01: Disable API key authentication
    // This enforces Microsoft Entra ID (managed identity) authentication only
    // API keys cannot be scoped, audited per user, or tied to an identity
    // Key-based auth is a security risk as keys can be leaked or shared
    publicNetworkAccess: 'Enabled'
  }
}

output id string = aiFoundryHub.id
output name string = aiFoundryHub.name
output principalId string = aiFoundryHub.identity.principalId
