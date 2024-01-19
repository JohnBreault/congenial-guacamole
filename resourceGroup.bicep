targetScope = 'subscription'

@description('Resource group name')
param resourceGroupName string

@description('Resource group location')
param resourceGroupLocation string = 'westus'

resource resourceGroupCreate 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}
