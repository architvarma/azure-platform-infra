variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "system_node_pool" {
  type = object({
    vm_size    = string
    node_count = number
  })
}

variable "user_node_pool" {
  type = object({
    name        = string
    vm_size    = string
    node_count = number
  })
}

variable "tags" {
  type = map(string)
}

variable "aad_rbac" {
  type = object({
    enabled                = bool
    azure_rbac_enabled     = bool
    admin_group_object_ids = list(string)
  })
}

variable "workload_identity_enabled" {
  type    = bool
  default = true
}