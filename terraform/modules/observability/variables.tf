variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "aks_cluster_id" {}

variable "retention_days" {
  type    = number
  default = 30
}

variable "alert_email" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
}