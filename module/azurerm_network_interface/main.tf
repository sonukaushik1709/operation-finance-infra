resource "azurerm_network_interface" "nic"{
    for_each = var.nics
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    dynamic "ip_configuration" {
        for_each = each.value.ip_configurations
        content {
            name = ip_configuration.value.name
        subnet_id = var.subnet_ids[ip_configuration.value.subnet_id]
        private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
        public_ip_address_id = var.pip_ids[ip_configuration.value.public_ip_address_id]

        }
        
    }
}

variable "subnet_ids"{
    type = map(string)
}
variable "pip_ids"{
    type = map(string)
}
variable "nics" {
    type = map(object({
         name = string
    resource_group_name = string
    location = string
    ip_configurations = map(object({
        name = string
        subnet_id = string
        private_ip_address_allocation = string
        public_ip_address_id = string

    }))
        
    }))
 
}
