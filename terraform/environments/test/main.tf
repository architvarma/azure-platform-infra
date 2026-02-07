module "backend" {
  source = "../../modules/backend"
}

locals {
  environment = "test"
  location    = "eastus"
}