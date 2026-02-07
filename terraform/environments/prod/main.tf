module "backend" {
  source = "../../modules/backend"
}

locals {
  environment = "prod"
  location    = "eastus"
}