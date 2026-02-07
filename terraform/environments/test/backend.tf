terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstate5697"
    container_name       = "tfstate"
    key                  = "platform/test/terraform.tfstate"
  }
}