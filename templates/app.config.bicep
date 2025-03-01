 param appConfigName string
//param appConfigEndpoint string
// param appConfigLabel string
// param subscriptionName string
param serviceLocation string = resourceGroup().location

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2021-03-01-preview' = {
  name: appConfigName
  location: serviceLocation
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}
