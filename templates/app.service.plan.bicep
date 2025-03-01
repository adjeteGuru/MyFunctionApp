param serviceLocation string
param appServicePlanName string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: serviceLocation
  sku: {
    name: 'Standard'
    tier: 'Dynamic'
  }
  kind: 'linux'
  properties: {
    reserved: true
    hyperV: false
    isSpot: false
    isXenon: false
    perSiteScaling: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
}
