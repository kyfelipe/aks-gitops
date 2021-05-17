module "postgresql" {
  source = "Azure/postgresql/azurerm"

  location            = azurerm_resource_group.conductor.location
  resource_group_name = azurerm_resource_group.conductor.name

  server_name                  = local.config.sql.server_name
  sku_name                     = local.config.sql.sku_name
  storage_mb                   = local.config.sql.storage_mb
  backup_retention_days        = local.config.sql.backup_retention_days
  geo_redundant_backup_enabled = local.config.sql.geo_redundant_backup_enabled
  administrator_login          = local.config.sql.admin.login
  administrator_password       = local.config.sql.admin.password
  server_version               = local.config.sql.server_version
  ssl_enforcement_enabled      = local.config.sql.ssl_enforcement_enabled
  db_names                     = local.config.sql.db.names
  db_charset                   = local.config.sql.db.charset
  db_collation                 = local.config.sql.db.collation

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
