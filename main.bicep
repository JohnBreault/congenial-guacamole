@description('''vnet prefix example:
  [
    "10.10.10.0/24"
  ]
''')
param vnetIpPrefixes array = [
  '10.10.10.0/24'
]

@description('Subscription Id')
param subscriptionId string = '00000000-0000-0000-0000-000000000000'

@description('Resource group name')
param resourceGroupName string = 'rg-bicep'

@description('Resource group location')
param resourceGroupLocation string =  'eastus'

// @description('Subnet name')
// param subnetName string = 'default'

// @description('Virtual Network')
// param subnetPrefix string = '10.10.10.0/25'

@description('''subnet prefix example:
  [
    {
      "name": "subnet1",
      "prefix": "10.10.10.0/25"
    },
    {
      "name": "subnet2",
      "prefix": 10.10.10.128/25"
    }
  ]
   ''')
param subnetArray array = []

@description('Virtual Network Name')
param vnetName string = 'default'

@description('Virtual Network Location')
param vnetLocation string = resourceGroupLocation

@description('Route Table Id')
param routeTableId string = ''

@description('Network Security Group Id')
param nsgId string = ''

module resourceGroupCreate 'resourceGroup.bicep' = {
  name: 'rg-bicep'
  scope: subscription(subscriptionId)
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: resourceGroupLocation
  }
}

module vnet 'vnet.bicep' = {
  name: vnetName
  scope: resourceGroup(subscriptionId, resourceGroupName)
  params: {
    vnetLocation: vnetLocation
    vnetIpPrefixes: vnetIpPrefixes
    subnetArray: subnetArray
    routeTableId: routeTableId
    nsgId: nsgId
  }
}

