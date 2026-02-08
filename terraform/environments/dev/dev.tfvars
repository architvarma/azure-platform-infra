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

aks_nsg_rules = [
  {
    name                       = "allow-kubelet-health"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "10250"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  },
  {
    name                       = "allow-node-internal"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
]

aks = {
  name               = "aks-platform-dev"
  dns_prefix         = "aksdev"
  kubernetes_version = "1.29.2"

  system_node_pool = {
    vm_size    = "Standard_DS2_v2"
    node_count = 1
  }

  user_node_pool = {
    name        = "usernp"
    vm_size    = "Standard_DS3_v2"
    node_count = 2
  }
}

aad_rbac = {
  enabled                = true
  azure_rbac_enabled     = true
  admin_group_object_ids = [
    "3dd68030-2de6-439f-9a8d-917fd389447a"
  ]
}

key_vault_name = "kv-platform-dev"