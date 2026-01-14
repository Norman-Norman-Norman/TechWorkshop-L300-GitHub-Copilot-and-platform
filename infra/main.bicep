// Main Bicep template for Zava Storefront infrastructure
// Exercise 06: AI Governance and Model Observability

@description('The location for all resources')
param location string = resourceGroup().location

@description('Environment name (dev, staging, prod)')
param environment string = 'dev'

@description('Unique suffix for resource names')
param resourceSuffix string = uniqueString(resourceGroup().id)

// Variables
var appServiceName = 'app-${resourceSuffix}'
var appServicePlanName = 'plan-${resourceSuffix}'
var logAnalyticsName = 'log-${resourceSuffix}'
var appInsightsName = 'appi-${resourceSuffix}'
var keyVaultName = 'kv-${resourceSuffix}'
var storageAccountName = 'st${resourceSuffix}'
var containerRegistryName = 'cr${resourceSuffix}'
var mlHubName = 'mlw-hub-${resourceSuffix}'
var mlProjectName = 'mlw-proj-${resourceSuffix}'

// Deploy Log Analytics Workspace
module logAnalytics 'modules/logAnalytics.bicep' = {
  name: 'logAnalytics'
  params: {
    name: logAnalyticsName
    location: location
  }
}

// Deploy Application Insights
module appInsights 'modules/appInsights.bicep' = {
  name: 'appInsights'
  params: {
    name: appInsightsName
    location: location
    logAnalyticsWorkspaceId: logAnalytics.outputs.id
  }
}

// Deploy Storage Account
module storageAccount 'modules/storage.bicep' = {
  name: 'storageAccount'
  params: {
    name: storageAccountName
    location: location
  }
}

// Deploy Key Vault
module keyVault 'modules/keyVault.bicep' = {
  name: 'keyVault'
  params: {
    name: keyVaultName
    location: location
  }
}

// Deploy Container Registry
module containerRegistry 'modules/containerRegistry.bicep' = {
  name: 'containerRegistry'
  params: {
    name: containerRegistryName
    location: location
  }
}

// Deploy App Service Plan
module appServicePlan 'modules/appServicePlan.bicep' = {
  name: 'appServicePlan'
  params: {
    name: appServicePlanName
    location: location
  }
}

// Deploy App Service with System-Assigned Managed Identity
module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    name: appServiceName
    location: location
    appServicePlanId: appServicePlan.outputs.id
    appInsightsConnectionString: appInsights.outputs.connectionString
    appInsightsInstrumentationKey: appInsights.outputs.instrumentationKey
    tags: {}
  }
}

// Deploy AI Foundry Hub (Microsoft.MachineLearningServices/workspaces with kind='hub')
module aiFoundryHub 'modules/aiFoundryHub.bicep' = {
  name: 'aiFoundryHub'
  params: {
    name: mlHubName
    location: location
    storageAccountId: storageAccount.outputs.id
    keyVaultId: keyVault.outputs.id
    appInsightsId: appInsights.outputs.id
    containerRegistryId: containerRegistry.outputs.id
    // Task 06.01: Disable API keys, enforce identity-only auth
    disableLocalAuth: true
  }
}

// Deploy AI Foundry Project
module aiFoundryProject 'modules/aiFoundryProject.bicep' = {
  name: 'aiFoundryProject'
  params: {
    name: mlProjectName
    location: location
    hubId: aiFoundryHub.outputs.id
    // Task 06.01: Disable API keys, enforce identity-only auth
    disableLocalAuth: true
  }
}

// Task 06.01: RBAC Role Assignment - Cognitive Services User for App Service
module roleAssignment 'modules/roleAssignment.bicep' = {
  name: 'roleAssignment'
  params: {
    principalId: appService.outputs.principalId
    aiFoundryHubId: aiFoundryHub.outputs.id
  }
}

// Task 06.02: Diagnostic Settings for AI Foundry
module diagnosticSettings 'modules/diagnosticSettings.bicep' = {
  name: 'diagnosticSettings'
  params: {
    aiFoundryHubName: mlHubName
    logAnalyticsWorkspaceId: logAnalytics.outputs.id
  }
  dependsOn: [
    aiFoundryHub
  ]
}

// Task 06.04: Azure Monitor Workbook for AI Services Observability
module workbook 'modules/workbook.bicep' = {
  name: 'workbook'
  params: {
    location: location
    logAnalyticsWorkspaceId: logAnalytics.outputs.id
  }
}

// Outputs
output appServiceUrl string = 'https://${appService.outputs.defaultHostName}'
output appServicePrincipalId string = appService.outputs.principalId
output logAnalyticsWorkspaceId string = logAnalytics.outputs.id
output aiFoundryHubId string = aiFoundryHub.outputs.id
output aiFoundryProjectId string = aiFoundryProject.outputs.id
