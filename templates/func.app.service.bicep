param storageAccountName string
param serviceLocation string
param functionAppName string
param appServicePlanName string
// param appConfigEndpoint string
// param appConfigLabel string
// param subscriptionName string
// param location string = resourceGroup().location
// param functionAppName string = '${storageAccountName}-func'
// param appServicePlanName string = '${functionAppName}-asp'  

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  location: serviceLocation
  properties: {
    accessTier: 'Cool'
    publicNetworkAccess: 'Enabled'
  }
}

resource myFunctionApp 'Microsoft.Web/sites@2021-02-01' = {
  name: functionAppName
  location: serviceLocation
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value};EndpointSuffix=core.windows.net'
        }
      ]
    }
  }
}

// module appSetting './app.service.settings.bicep' = {
//   name: 'appSettingDeploy'
//   params: {
//     name: '${functionAppName}/appsetings'
//    currentAppSettings: {
//       'APPINSIGHTS_INSTRUMENTATIONKEY': 'InstrumentationKey=${appInsights.properties.InstrumentationKey};IngestionEndpoint=${appInsights.properties.IngestionEndpoint}'
//     }
//     updatedAppSettings: {
//       'APPINSIGHTS_INSTRUMENTATIONKEY': appInsights.properties.InstrumentationKey
//     }
//     APP_CONFIG_ENDPOINT: appConfigEndpoint
//     APP_CONFIG_LABEL: appConfigLabel
//     SubscriptionName: subscriptionName
//   }
// }
