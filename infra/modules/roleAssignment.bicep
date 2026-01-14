// RBAC Role Assignment module
// Task 06.01: Grant Cognitive Services User role to App Service managed identity

@description('Principal ID of the App Service managed identity')
param principalId string

@description('AI Foundry Hub ID')
param aiFoundryHubId string

// Cognitive Services User role definition ID
// This role allows access to Cognitive Services resources using identity-based auth
var cognitiveServicesUserRoleId = 'a97b65f3-24c7-4388-baec-2e87135dc908'

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(aiFoundryHubId, principalId, cognitiveServicesUserRoleId)
  scope: resourceGroup()
  properties: {
    principalId: principalId
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', cognitiveServicesUserRoleId)
    principalType: 'ServicePrincipal'
    description: 'App Service managed identity access to AI Foundry for chatbot'
  }
}

output roleAssignmentId string = roleAssignment.id
