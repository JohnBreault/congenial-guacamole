@description('''vnet prefix example:
  [
    "10.10.10.0/24"
  ]
''')
param vnetIpPrefixes array = [
  '10.10.10.0/24'
]

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

// @description('Virtual Network')
// param subnetPrefix string = '10.10.10.0/25'

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
    subnets: [for subnet in subnetArray: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.prefix
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

output vnetId string = vnetCreate.id
