param keyVaultName string
param location string = resourceGroup().location
param tenantId string = subscription().tenantId 
param appInsightsConnectionStringName string
param servicePrincipalObjectId string

resource keyvault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: { 
      family: 'A'
      name: 'standard'
    }
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: servicePrincipalObjectId
        permissions: {
          secrets: [
            'get'
            'list'
            'set'
          ]
        }
      }
    ]
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      ipRules: [
        {
          value: '82.19.209.43'
        }
      ]
    }
  }
}

// Reference the first Bicep file as a module
module appInsightsDeploy 'app.insights.bicep' = {
  name: 'appInsightsDeploy'
  params: {
    serviceLocation: location
    appInsightsName: '${keyVaultName}-appinsights'
  }
}


resource appInsightsConnectionString 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  parent: keyvault
    name: appInsightsConnectionStringName
  properties: {
    value: appInsightsDeploy.outputs.appInsightsConnectionString
  }
//   dependsOn: [
//     keyvault
//     appInsights
//   ]
}
