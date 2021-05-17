module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.conductor.name
  kubernetes_version               = local.config.aks.kubernetes_version
  orchestrator_version             = local.config.aks.orchestrator_version
  prefix                           = local.config.aks.prefix_name
  network_plugin                   = local.config.aks.network_plugin
  vnet_subnet_id                   = azurerm_subnet.subnet.id
  os_disk_size_gb                  = local.config.aks.os_disk_size_gb
  sku_tier                         = local.config.aks.sku_tier
  enable_role_based_access_control = local.config.aks.enable_role_based_access_control
  rbac_aad_managed                 = local.config.aks.rbac_aad_managed
  private_cluster_enabled          = local.config.aks.private_cluster_enabled
  enable_http_application_routing  = local.config.aks.enable_http_application_routing
  enable_azure_policy              = local.config.aks.enable_azure_policy
  enable_auto_scaling              = local.config.aks.enable_auto_scaling
  agents_count                     = local.config.aks.agents.count
  agents_pool_name                 = local.config.aks.agents.pool_name
  agents_availability_zones        = local.config.aks.agents.availability_zones
  agents_type                      = local.config.aks.agents.type

  network_policy                 = local.config.aks.network.policy
  net_profile_dns_service_ip     = local.config.aks.network.profile.dns_service_ip
  net_profile_docker_bridge_cidr = local.config.aks.network.profile.docker_bridge_cidr
  net_profile_service_cidr       = local.config.aks.network.profile.service_cidr

  depends_on = [
    azurerm_resource_group.conductor,
    azurerm_virtual_network.vnet,
    module.postgresql
  ]
}
