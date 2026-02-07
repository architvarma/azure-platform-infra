locals {
  environment = "dev"
  location    = "eastus"
}

resource "azurerm_resource_group" "platform" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source = "../../modules/vnet"

  name                = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags
}