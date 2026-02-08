# locals {
#   environment = "dev"
#   location    = "eastus"
# }

# 1. Resource Group
resource "azurerm_resource_group" "platform" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# 2. VNet + Subnets
module "vnet" {
  source = "../../modules/vnet"

  name                = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags
}

# 3. NSG for AKS Nodes
module "aks_nsg" {
  source = "../../modules/nsg"

  name                = "nsg-aks-nodes-dev"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  security_rules      = var.aks_nsg_rules
  tags                = var.tags
}

# 4. NSG ↔ Subnet Association (THIS IS STEP 4.2)
resource "azurerm_subnet_network_security_group_association" "aks_nodes" {
  subnet_id                 = module.vnet.subnet_ids["aks_nodes"]
  network_security_group_id = module.aks_nsg.nsg_id
}

data "azurerm_client_config" "current" {}

module "keyvault" {
  source = "../../modules/keyvault"

  name                = var.key_vault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

#5 AKS Cluster
module "aks" {
  source = "../../modules/aks"

  name                = var.aks.name
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  dns_prefix          = var.aks.dns_prefix
  kubernetes_version  = var.aks.kubernetes_version

  subnet_id = module.vnet.subnet_ids["aks_nodes"]

  system_node_pool = var.aks.system_node_pool
  # user_node_pool   = var.aks.user_node_pool

  aad_rbac = var.aad_rbac

  tags = var.tags

  depends_on = [
    module.keyvault
  ]
}

resource "azurerm_role_assignment" "aks_admins" {
  scope                = module.aks.cluster_id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = var.aad_rbac.admin_group_object_ids[0]
}

resource "azurerm_role_assignment" "aks_admins_2" {
  scope                = module.aks.cluster_id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = var.aad_rbac.admin_group_object_ids[1]
}
