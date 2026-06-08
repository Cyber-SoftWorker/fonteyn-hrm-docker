param sqlServerName string = 'fonteyn-db-server'
param databaseName string = 'fonteyn-hrm-db'
param location string = 'francecentral'

param tags object = {
  Project: 'Fonteyn-HRM'
  Environment: 'Demo'
  Service: 'AzureSQLDatabase'
  Purpose: 'Database-for-HRM-application'
}

resource existingSqlServer 'Microsoft.Sql/servers@2021-11-01' existing = {
  name: sqlServerName
}

resource hrmDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = {
  parent: existingSqlServer
  name: databaseName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  properties: {
    maxSizeBytes: 2147483648
  }
  tags: tags
}

output createdDatabaseName string = hrmDatabase.name