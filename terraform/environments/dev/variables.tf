variable "location" {
  type        = string
  description = "Azure region"
}

variable "environment" {
  type        = string
  description = "Environment name (dev/test/prod)"
}

variable "vnet_name" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "address_space" {
  type        = list(string)
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  type = map(string)
}

variable "aks_nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "aks" {
  type = object({
    name               = string
    dns_prefix         = string
    kubernetes_version = string
    system_node_pool = object({
      vm_size    = string
      node_count = number
    })
    # user_node_pool = object({
    #   name        = string
    #   vm_size    = string
    #   node_count = number
    # })
  })
}

variable "aad_rbac" {
  type = object({
    azure_rbac_enabled     = bool
    admin_group_object_ids = list(string)
  })
}

variable "key_vault_name" {
  type = string
}

################################
# Observability (Day 9)
################################

variable "observability_name" {
  type        = string
  description = "Name for observability resources"
}

variable "observability_retention_days" {
  type        = number
  description = "Log Analytics retention days"
}

variable "observability_alert_email" {
  type        = string
  description = "Email for Azure Monitor alerts"
}

# variable "terraform_principal_object_id" {
#   description = "Object ID of the user / SP / MI running Terraform"
#   type        = string
# }