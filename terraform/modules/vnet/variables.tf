variable "name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the VNet"
  type        = string
}

variable "address_space" {
  description = "VNet CIDR blocks"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets with CIDR ranges"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}