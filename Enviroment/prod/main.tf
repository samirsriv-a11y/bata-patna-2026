module "resource_group" {

  source         = "../../Child-module/azurerm_resource_group"
  rgs= var.rgs

}
module "virtual_network" {
  source          = "../../Child-module/azurerm_virtual_network"
  virtual_network = var.vnets
  depends_on      = [module.resource_group]

}
module "subnet" {
  source     = "../../Child-module/azurerm_subnet"
  subnets    = var.subnets
  depends_on = [module.resource_group, module.virtual_network]

}
module "public_ip" {
  source     = "../../Child-module/azurerm_public_ip"
  pips       = var.pips
  depends_on = [module.resource_group, module.subnet]
}

module "virtual_machine" {
  source = "../../Child-module/azurerm_virtual_machine"
  vms    = var.vms
  depends_on = [ module.public_ip,module.subnet,module.resource_group ]
}