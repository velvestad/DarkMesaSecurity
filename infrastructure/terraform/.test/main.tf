module "external_networking" {
  source = "./external"
}

module "site-1_networking" {
  source   = "./site-1/networking"
  external = module.external_networking.external
}

#module "site-1_virtual_machines" {
#  source = "./site-1/virtual_machines"
#}
