//tag infos
param owner string
param costCenter string
param application string
param descp string
param repo string

//logWP infos for names
param appShort string
param domainShort string
param env string
param version string

//logWP infos for construction
param location string = resourceGroup().location
param retentionDays int = 30

//variables
var tag = {
  owner: owner
  costCenter: costCenter
  application: application
  descp: descp
  repo: repo
}

var partName = '${domainShort}-${appShort}-${env}-${version}'
var dataFactoryName = 'df-${partName}'
var logsWPName = 'lg-${partName}'

//resource
resource logAnalyticsWorkSpace 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' existing = {
  name: logsWPName
}

var workspaceId = resourceId('Microsoft.OperationalInsights/workspaces', logAnalyticsWorkSpace.name)
//modules
module logWS '../../modules//data-factory/data-factory.bicep' = {
  name: 'data-factory-deployment'
  params: {
    location: location
    tags: tag
    dataFactoryName: dataFactoryName
    workspaceId: workspaceId
  }
}
