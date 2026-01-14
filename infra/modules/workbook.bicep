// Azure Monitor Workbook for AI Services Observability
// Task 06.04: Deploy observability workbook

@description('Name of the workbook')
param workbookName string = 'AI Services Observability'

@description('Location for the resource')
param location string = resourceGroup().location

@description('Log Analytics Workspace ID')
param logAnalyticsWorkspaceId string

@description('Workbook display name')
param displayName string = 'AI Services Observability'

// Load the workbook JSON content
var workbookContent = loadTextContent('workbook.json')

resource workbook 'Microsoft.Insights/workbooks@2023-06-01' = {
  name: guid(resourceGroup().id, workbookName)
  location: location
  kind: 'shared'
  properties: {
    category: 'workbook'
    displayName: displayName
    serializedData: workbookContent
    sourceId: logAnalyticsWorkspaceId
  }
}

output workbookId string = workbook.id
output workbookName string = workbook.name
