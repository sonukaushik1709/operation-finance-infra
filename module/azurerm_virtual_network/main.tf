resource "azurerm_virtual_network" "vnet"{
    for_each = var.vnets
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
   address_space = each.value.address_space
  dynamic "subnet" {
    for_each = each.value.subnets
    content {
        name = subnet.value.name
    address_prefixes = subnet.value.address_prefixes

    }
    
   } 
}
output "subnet_ids" {
  value = {
    for name, v in azurerm_virtual_network.vnet : name => {
      for s in v.subnet :
      s.name => s.id
    }
  }
}


variable "vnets"{
    type = map(object({
         name = string
    resource_group_name = string
    location = string
   address_space       = list(string)
   subnets = map(object({
       name = string
    address_prefixes = list(string)


   }))


    }))
}