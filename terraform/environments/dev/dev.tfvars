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
  kubernetes_version = "1.34.2"

  system_node_pool = {
    vm_size    = "Standard_DC2ds_v3"
    node_count = 1
  }

#   user_node_pool = {
#     name        = "usernp"
#     vm_size    = "Standard_DC2ds_v3"
#     node_count = 2
#   }
}

aad_rbac = {
  azure_rbac_enabled     = true
  admin_group_object_ids = [
    "3dd68030-2de6-439f-9a8d-917fd389447a", "a8d8e545-f3f9-42d2-ae8e-0d450ef0bb2e"
  ]
}

key_vault_name = "kv-platform-dev-arc"

################################
# Observability (DEV)
################################

observability_name           = "obs-aks-dev"
observability_retention_days = 30
observability_alert_email    = "archit5697@gmail.com"

# terraform_principal_object_id = "04b07795-8ddb-461a-bbee-02f9e1bf7b46"