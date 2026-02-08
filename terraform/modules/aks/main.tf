resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  private_cluster_enabled = false
  oidc_issuer_enabled       = var.workload_identity_enabled
  workload_identity_enabled = var.workload_identity_enabled

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  default_node_pool {
    name                = "system"
    vm_size             = var.system_node_pool.vm_size
    node_count          = var.system_node_pool.node_count
    vnet_subnet_id      = var.subnet_id
    orchestrator_version = var.kubernetes_version
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    azure_rbac_enabled     = var.aad_rbac.azure_rbac_enabled
    admin_group_object_ids = var.aad_rbac.admin_group_object_ids
    }

  tags = var.tags
}

# resource "azurerm_kubernetes_cluster_node_pool" "user" {
#   name                  = var.user_node_pool.name
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
#   vm_size               = var.user_node_pool.vm_size
#   node_count            = var.user_node_pool.node_count
#   vnet_subnet_id        = var.subnet_id
#   mode                  = "User"
# }