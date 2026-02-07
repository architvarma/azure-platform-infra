module "backend" {
  source = "../../modules/backend"
}

locals {
  environment = "dev"
  location    = "eastus"
}