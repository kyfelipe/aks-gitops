module "postgresql" {
  source = "Azure/postgresql/azurerm"

  location            = azurerm_resource_group.conductor.location
  resource_group_name = azurerm_resource_group.conductor.name

  server_name                  = "postgresql-aks"
  sku_name                     = "B_Gen5_1"
  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  administrator_login          = "psqladmin"
  administrator_password       = "qF2Wx5F6mzeuvQA"
  server_version               = "11"
  ssl_enforcement_enabled      = false
  db_names                     = ["conductor"]
  db_charset                   = "UTF8"
  db_collation                 = "English_United States.1252"

  firewall_rule_prefix = "firewall-"
  firewall_rules = [
    { name = "aks", start_ip = "120.0.0.0", end_ip = "120.244.244.244" }
  ]

  # vnet_rule_name_prefix = "postgresql-vnet-rule-"
  # vnet_rules = [
  #   { name = "subnet1", subnet_id = azurerm_subnet.subnet.id }
  # ]

  depends_on = [
    azurerm_resource_group.conductor,
    azurerm_virtual_network.vnet
  ]
}
