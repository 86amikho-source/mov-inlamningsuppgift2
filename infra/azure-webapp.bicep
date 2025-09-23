param location string = resourceGroup().location
param appName string
param skuName string = 'P1v2'
param dockerImage string  // t.ex. 'dockerhubuser/mov2:1.0.0'
param dockerRegistryUrl string = 'https://index.docker.io/v1/'

resource plan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: '${appName}-plan'
  location: location
  sku: {
    name: skuName
    tier: 'PremiumV2'
    size: 'P1v2'
    family: 'P'
    capacity: 1
  }
}

resource app 'Microsoft.Web/sites@2023-12-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOCKER|${dockerImage}'
      appSettings: [
        { name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE', value: 'false' }
        { name: 'PORT', value: '8080' }
        { name: 'APP_NAME', value: 'MOV Inlämningsuppgift 2' }
        { name: 'DOCKER_REGISTRY_SERVER_URL', value: dockerRegistryUrl }
      ]
      alwaysOn: true
      healthCheckPath: '/healthz'
    }
  }
  kind: 'app,linux'
}
