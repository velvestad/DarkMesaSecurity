module "networking" {
  source = "./site-1/networking"
}

module "virtual_machines" {
  source = "./site-1/virtual_machines"
}