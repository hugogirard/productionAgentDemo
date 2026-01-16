targetScope = 'subscription'

@description('The location of the resource group')
param resourceLocation string

param resourceGroupName string

@description('The model for the chat completion')
param chatCompleteionDeploymentName string

@description('The SKU of the chat completion model')
param chatDeploymentSku string

@description('The properties of the chat model')
param chatModelProperties object

@description('The chat model SKU capacity')
param chatModelSkuCapacity int

@description('The embedding deployment name')
param embeddingDeploymentName string

@description('The embedding deployment SKU')
param embeddingDeploymentSku string

@description('The embedding model properties')
param embeddingModelProperties object

@description('The embedding model SKU capacity')
param embeddingModelSkuCapacity int

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: resourceLocation
}

var suffix = uniqueString(rg.id)

/*************************************************
*  Workload dependencies
*************************************************/

module cosmosdb 'modules/cosmosdb.bicep' = {
  scope: rg
  params: {
    location: resourceLocation
    cosmosDBResourceName: 'cos-${suffix}'
  }
}

module registry 'br/public:avm/res/container-registry/registry:0.9.3' = {
  scope: rg
  params: {
    // Required parameters
    name: 'acr${suffix}'
    // Non-required parameters
    acrSku: 'Standard'
    location: resourceLocation
    acrAdminUserEnabled: true
  }
}

module aisearch 'br/public:avm/res/search/search-service:0.12.0' = {
  scope: rg
  params: {
    name: 'search-${suffix}'
    authOptions: {
      aadOrApiKey: {
        aadAuthFailureMode: 'http401WithBearerChallenge'
      }
    }
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    location: resourceLocation
    managedIdentities: {
      systemAssigned: true
    }
  }
}

/*************************************************
*  Azure AI Foundry resources
*************************************************/

module foundry 'modules/foundry.bicep' = {
  scope: rg
  params: {
    location: resourceLocation
    accountName: 'foundry-${suffix}'
  }
}

module chatCompletionModel 'modules/model-deployment.bicep' = {
  scope: rg
  params: {
    aiFoundryAccountName: foundry.outputs.resourceName
    deploymentName: chatCompleteionDeploymentName
    deploymentSku: chatDeploymentSku
    modelProperties: chatModelProperties
    skuCapacity: chatModelSkuCapacity
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
  }
}

module embeddingnModel 'modules/model-deployment.bicep' = {
  scope: rg
  params: {
    aiFoundryAccountName: foundry.outputs.resourceName
    deploymentName: embeddingDeploymentName
    deploymentSku: embeddingDeploymentSku
    modelProperties: embeddingModelProperties
    skuCapacity: embeddingModelSkuCapacity
    versionUpgradeOption: 'NoAutoUpgrade'
  }
  dependsOn: [
    chatCompletionModel // To avoid deployment concurrency and fail the bicep
  ]
}
