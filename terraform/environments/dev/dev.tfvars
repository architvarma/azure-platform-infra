environment = "dev"
location    = "eastus"

vnet_name            = "vnet-platform-dev"
resource_group_name  = "rg-platform-dev"

address_space = ["10.10.0.0/16"]

subnets = {
  aks_nodes = {
    address_prefixes = ["10.10.1.0/24"]
  }
  ingress = {
    address_prefixes = ["10.10.2.0/24"]
  }
  private_endpoints = {
    address_prefixes = ["10.10.3.0/24"]
  }
}

tags = {
  environment = "dev"
  owner       = "platform"
  managed_by  = "terraform"
}