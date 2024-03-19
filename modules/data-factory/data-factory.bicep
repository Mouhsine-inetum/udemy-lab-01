@description('tags needed by the resource env')
param tags object

@description('location of the resource')
param location string

@description('the name of the resource')
param dataFactoryName string

@description('the id of hte workspace that will be linked to the data factory')
param workspaceId string


resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
  tags:tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {

  }
}

resource logAnalyticsWorkSpaceDataFactory 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${dataFactory.name}-insights-analytics'
  scope: dataFactory
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'ActivityRuns'
        enabled: true
      }
      {
        category: 'PipelineRuns'
        enabled: true
      }
      {
        category: 'TriggerRuns'
        enabled: true
      }
    ]
  }
}


output dataFactoryId string = dataFactory.id
output dataFactoryName string = dataFactory.name
output dataFactoryPrincipal string = dataFactory.identity.principalId
