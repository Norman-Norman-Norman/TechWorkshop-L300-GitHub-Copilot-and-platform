// App Service module with System-Assigned Managed Identity

@description('Name of the App Service')
param name string

@description('Location for the resource')
param location string

@description('App Service Plan ID')
param appServicePlanId string

@description('Application Insights Connection String')
@secure()
param appInsightsConnectionString string

@description('Application Insights Instrumentation Key')
@secure()
param appInsightsInstrumentationKey string

@description('Tags for the resource')
param tags object = {}

resource appService 'Microsoft.Web/sites@2023-12-01' = {
  name: name
  location: location
  kind: 'app,linux'
  tags: union(tags, { 'azd-service-name': 'web' })
  // Task 06.01: Enable System-Assigned Managed Identity
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      alwaysOn: false
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      appSettings: [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsightsConnectionString
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsInstrumentationKey
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
      ]
    }
  }
}

output id string = appService.id
output name string = appService.name
output defaultHostName string = appService.properties.defaultHostName
// Task 06.01: Output the managed identity principal ID for RBAC assignment
output principalId string = appService.identity.principalId
