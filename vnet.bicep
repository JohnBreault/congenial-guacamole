@description('''vnet prefix example:
  [
    "10.10.10.0/24"
  ]
''')
param vnetIpPrefixes array = [
  '10.10.10.0/24'
]
param subnetName string = 'default'

@description('Virtual Network')
param subnetPrefix string = '10.10.10.0/25'

param vnetName string = 'default'
param vnetLocation string = resourceGroup().location
param routeTableId string = ''
param nsgId string = ''

resource vnetCreate 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: vnetLocation
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  properties: {
    addressSpace: {
      addressPrefixes: vnetIpPrefixes
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          routeTable: ((!empty(routeTableId)) ? { // if routeTableId is not empty, then create a routeTable object
            id:  routeTableId
          }: null)
          networkSecurityGroup: ((!empty(nsgId)) ? { // if nsgId is not empty, then create a nsg object
            id: nsgId
          }: null)
        }
      }
    ]
  }
}
