module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.conductor.name
  kubernetes_version               = "1.19.9"
  orchestrator_version             = "1.19.9"
  prefix                           = "conductor"
  network_plugin                   = "azure"
  vnet_subnet_id                   = azurerm_subnet.subnet.id
  os_disk_size_gb                  = 50
  sku_tier                         = "Free"
  enable_role_based_access_control = false
  rbac_aad_managed                 = false
  private_cluster_enabled          = false
  enable_http_application_routing  = false
  enable_azure_policy              = false
  enable_auto_scaling              = false
  agents_count                     = 3
  agents_pool_name                 = "nodepool"
  agents_availability_zones        = ["1", "2"]
  agents_type                      = "VirtualMachineScaleSets"

  network_policy                 = "azure"
  net_profile_dns_service_ip     = "10.0.0.10"
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "10.0.0.0/16"

  depends_on = [
    azurerm_resource_group.conductor,
    azurerm_virtual_network.vnet,
    module.postgresql
  ]
}
