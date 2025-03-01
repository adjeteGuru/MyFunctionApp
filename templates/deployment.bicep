param subscriptionName string
param serviceLocation string = resourceGroup().location

param appInsightsConnectionStringName string = 'AppInsights-ConnectionString'
// @secure()
// param appInsightsInstrumentationKey string

param appConfigName string = '${subscriptionName}-appconfig'

param servicePrincipalObjectId string
param tenantId string = subscription().tenantId
var appServicePlanName = '${subscriptionName}-asp'
var functionAppName = '${subscriptionName}-func'
var storageAccountName = '${subscriptionName}storage'
var keyVaultName = '${subscriptionName}-kv'
var appInsightsName = '${subscriptionName}-appinsights'
// var appConfigEndpoint = 'https://${appConfigName}.azconfig.io'
// var appConfigLabel = 'key:dev'

module appServicePlanDeploy 'app.service.plan.bicep' = {
  name: 'appServicePlanDeploy'
  params: {
    serviceLocation: serviceLocation
    appServicePlanName: appServicePlanName
  }
}

module appConfigDeploy 'app.config.bicep' = {
  name: 'appConfigDeploy'
  params: {
    appConfigName: appConfigName
    // appConfigEndpoint: appConfigEndpoint
    // appConfigLabel: appConfigLabel
  }
}

module appServiceDeploy 'func.app.service.bicep' = {
  name: 'appServiceDeploy'
  dependsOn: [
    appServicePlanDeploy
  ]
  params: {
    storageAccountName: storageAccountName
    serviceLocation: serviceLocation
    functionAppName: functionAppName
    appServicePlanName: appServicePlanName
    // appConfigEndpoint: appConfigEndpoint
    // appConfigLabel: appConfigLabel
  }
}

module appInsightsDeploy 'app.Insights.bicep' = {
  name: 'appInsightsDeploy'
  params: {
    appInsightsName: appInsightsName
    serviceLocation: serviceLocation
  }
} 


module keyVaultDeploy 'keyvault.bicep' = {
  name: 'keyVaultDeploy'
  params: {
    keyVaultName: keyVaultName
    location: serviceLocation
    appInsightsConnectionStringName: appInsightsConnectionStringName
    servicePrincipalObjectId: servicePrincipalObjectId
    tenantId: tenantId
  }
}
