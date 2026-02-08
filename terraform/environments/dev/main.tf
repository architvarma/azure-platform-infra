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