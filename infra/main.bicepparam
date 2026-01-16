using 'main.bicep'

param resourceGroupName = 'rg-agent-framework-demo'

param resourceLocation = 'westus'

param chatCompleteionDeploymentName = 'gpt-5-mini'

param chatDeploymentSku = 'GlobalStandard'

param chatModelProperties = {
  format: 'OpenAI'
  name: 'gpt-5-mini'
  version: '2025-08-07'
}

param chatModelSkuCapacity = 150

param embeddingDeploymentName = 'text-embedding-3-large'

param embeddingDeploymentSku = 'GlobalStandard'

param embeddingModelProperties = {
  format: 'OpenAI'
  name: 'text-embedding-3-large'
  version: '1'
}

param embeddingModelSkuCapacity = 150
