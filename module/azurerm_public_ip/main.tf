resource "azurerm_public_ip" "pip"{
    for_each = var.pips
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.loaction
    allocation_method = each.value.allocation_method
     tags = {
    environment = "dev"
  }
}

variable "pips"{
    type = map(object({

        name = string
    resource_group_name = string
    loaction = string
    allocation_method = string

    }))
}
output "pip_ids"{
    value = { for name,p in azurerm_public_ip.pip : name => p.id }
}