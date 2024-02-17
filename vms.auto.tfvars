vms = {
  1 = {
    name        = "linux-jump-box"
    rg          = "lab_vm"
    location    = "East US"
    size        = "Standard_DS1_v2"
    adminuser   = null
    nicname     = "nic-jump-box"
    ssh         = null
    caching     = "ReadWrite"
    diskgb      = 30
    diskname    = "linux_jump_disk"
    storagetipe = "Standard_LRS"
    publisher   = "Canonical"
    offer       = "UbuntuServer"
    sku         = "16.04-LTS"
    version     = "latest"
  }

  2 = {
    name        = "linux-0"
    rg          = "lab_vm"
    location    = "East US"
    size        = "Standard_DS1_v2"
    adminuser   = null
    nicname     = "nic-0"
    ssh         = null
    caching     = "ReadWrite"
    diskgb      = 30
    diskname    = "linux_0_disk"
    storagetipe = "Standard_LRS"
    publisher   = "Canonical"
    offer       = "UbuntuServer"
    sku         = "16.04-LTS"
    version     = "latest"
  }

  3 = {
    name        = "linux-1"
    rg          = "lab_vm"
    location    = "East US"
    size        = "Standard_DS1_v2"
    adminuser   = null
    nicname     = "nic-1"
    ssh         = null
    caching     = "ReadWrite"
    diskgb      = 30
    diskname    = "linux_1_disk"
    storagetipe = "Standard_LRS"
    publisher   = "Canonical"
    offer       = "UbuntuServer"
    sku         = "16.04-LTS"
    version     = "latest"
  }
}