module "rg" {
  source = "../../module/azurerm_resource_group"
  rgs    = var.rgs
}
module "stg" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_storage_account"
  stgs       = var.stgs
}
module "container" {
  depends_on = [module.rg, module.stg]
  source     = "../../module/azurerm_storage_container"
  containers = var.containers
  stg_ids    = module.stg.stg_ids
}
module "vnet" {
  source     = "../../module/azurerm_virtual_network"
  depends_on = [module.rg]
  vnets      = var.vnets
}
module "nsg"{
  source = "../../module/azurerm_network_security_group"
  depends_on = [module.rg,module.vnet]
  nsgs = var.nsgs
}