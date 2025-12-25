rgs = {
  rg1 = {
    name     = "opeartion-infra"
    location = "centralindia"
  }
  rg2 = {
    name     = "opeartion-infra2"
    location = "centralindia"
  }
}
stgs = {
  stg1 = {
    name                     = "blinket"
    location                 = "centralindia"
    resource_group_name      = "opeartion-infra"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}
containers = {
  conatiner1 = {
    name                  = "opeartion-infra-container"
    storage_account_id    = "stg1"
    container_access_type = "private"


  }

}
vnets = {
  vnet1 = {
    name                = "opeartion-infra-vnet"
    resource_group_name = "opeartion-infra"
    location            = "centralindia"
    address_space       = ["10.0.0.0/16"]

    subnets = {
      subnet1 = {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }

      subnet2 = {
        name             = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  }
}
nsgs = {
  nsg1 = {
    name                = "frontend-subnet-nsg"
    location            = "centralindia"
    resource_group_name = "opeartion-infra"

    security_rules = {
      rules1 = {
        name                       = "frontend-test123"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }

    tags = {
      environment = "dev"
    }
  }

  nsg2 = {
    name                = "backend-subnet-nsg"
    location            = "centralindia"
    resource_group_name = "opeartion-infra"

    security_rules = {
      rules1 = {
        name                       = "backend-test123"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }

    tags = {
      environment = "dev"
    }
  }
}
associations = {
  association1 = {
    subnet_id                 = "frontend-subnet"
    network_security_group_id = "nsg1"
  }
  association2 = {
    subnet_id                 = "backend-subnet"
    network_security_group_id = "nsg2"
  }
}

pips = {
  pip1 = {
    name                = "frontend-vm-pip"
    resource_group_name = "opeartion-infra"
    loaction            = "centralindia"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "backend-vm-pip"
    resource_group_name = "opeartion-infra"
    loaction            = "centralindia"
    allocation_method   = "Static"
  }
}
nics = {
  nic1 = {
    name                = "frontendvm-nic"
    resource_group_name = "opeartion-infra"
    location            = "centralindia"
    ip_configurations = {
      ip_configuration1 = {
        name                          = "internal"
        subnet_id                     = "frontend-subnet"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "pip1"

      }
    }

  }
  nic2 = {
    name                = "backendvm-nic"
    resource_group_name = "opeartion-infra"
    location            = "centralindia"
    ip_configurations = {
      ip_configuration2 = {
        name                          = "internal"
        subnet_id                     = "backend-subnet"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "pip2"

      }
    }

  }
}