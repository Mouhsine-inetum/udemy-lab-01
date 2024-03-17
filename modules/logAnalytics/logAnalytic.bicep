@description('tags that the resource needs')
param tags object

@description('the name of the log space name')
param name string

@description('location of the resource')
param location string

@description('log retention days')
param retentionDays int

@description('the sku of the log space')
param sku string = 'PerGB2018'

@allowed(
  ['Enabled'
  'Disabled'])
@description('net access type for log analytics ingestion access')
param publicNetworkAccessForIngestion string = 'Enabled'

@allowed(
  ['Enabled'
  'Disabled'])
@description('net access type for log analytics Query access')
param publicNetworkAccessForQuery string = 'Enabled'


resource AnalyticsWS 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: name
  location: location

  properties: {
    sku: {
      name: sku
    }
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    retentionInDays:retentionDays
  }
}

output logSpaceName string = AnalyticsWS.name
output logSpaceId string = AnalyticsWS.id
