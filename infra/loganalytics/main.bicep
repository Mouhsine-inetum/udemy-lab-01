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
  repo : repo
}

var logsWPName = 'lg-${domainShort}-${appShort}-${env}-${version}'


//modules
module logWS '../../modules/logAnalytics/logAnalytic.bicep' = {
  name: 'lgws-deployment-${env}-${version}'
  params: {
    location: location
    name: logsWPName
    retentionDays: retentionDays
    tags: tag
  }
}
