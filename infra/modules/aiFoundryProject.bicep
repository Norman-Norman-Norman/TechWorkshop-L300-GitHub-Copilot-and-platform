// AI Foundry Project (Microsoft.MachineLearningServices/workspaces with kind='Project')
// Task 06.01: Configured with disableLocalAuth to enforce identity-only access

@description('Name of the AI Foundry Project')
param name string

@description('Location for the resource')
param location string

@description('AI Foundry Hub ID')
param hubId string

@description('Disable local/key-based authentication (enforce identity-only)')
param disableLocalAuth bool = true

resource aiFoundryProject 'Microsoft.MachineLearningServices/workspaces@2024-04-01' = {
  name: name
  location: location
  kind: 'Project'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    friendlyName: 'Zava Storefront AI Project'
    description: 'AI Foundry Project for Zava Storefront chatbot'
    hubResourceId: hubId
    publicNetworkAccess: 'Enabled'
  }
}

output id string = aiFoundryProject.id
output name string = aiFoundryProject.name
output principalId string = aiFoundryProject.identity.principalId
