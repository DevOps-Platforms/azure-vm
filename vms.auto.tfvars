vms = {
  1 = {
    name        = "linux-1"
    rg          = "lab_vm"
    location    = "East US"
    size        = "Standard_DS1_v2"
    adminuser   = ""
    nicname     = "nic-1"
    ssh         = ""
    caching     = "ReadWrite"
    diskgb      = 30
    diskname    = "linux_01_disk"
    storagetipe = "Standard_LRS"
    publisher   = "Canonical"
    offer       = "UbuntuServer"
    sku         = "16.04-LTS"
    version     = "latest"
  }

  2 = {
    name        = "linux-2"
    rg          = "lab_vm"
    location    = "East US"
    size        = "Standard_DS1_v2"
    adminuser   = ""
    nicname     = "nic-2"
    ssh         = ""
    caching     = "ReadWrite"
    diskgb      = 30
    diskname    = "linux_02_disk"
    storagetipe = "Standard_LRS"
    publisher   = "Canonical"
    offer       = "UbuntuServer"
    sku         = "16.04-LTS"
    version     = "latest"
  }

  3 = {
    name        = "linux-3"
    rg          = "lab_vm"
    location    = "East US"
    size        = "Standard_DS1_v2"
    adminuser   = ""
    nicname     = "nic-3"
    ssh         = ""
    caching     = "ReadWrite"
    diskgb      = 30
    diskname    = "linux_03_disk"
    storagetipe = "Standard_LRS"
    publisher   = "Canonical"
    offer       = "UbuntuServer"
    sku         = "16.04-LTS"
    version     = "latest"
  }
}

