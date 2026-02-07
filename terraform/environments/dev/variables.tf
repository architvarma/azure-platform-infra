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