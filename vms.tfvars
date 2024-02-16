vms = {
    1 = {
    name        = "linux-jump-box"
    rg          = var.rg_name
    Location    = var.rg_location
    sise        = "Standard_DS1_v2"
    adminuser   = var.DEVOPS_AZURE_ADMIN_USER
    nicname     = var.nics[0]["name"]
    ssh         = var.DEVOPS_AZURE_PUBLIC_SSH
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
    rg          = var.rg_name
    Location    = var.rg_location
    sise        = "Standard_DS1_v2"
    adminuser   = var.DEVOPS_AZURE_ADMIN_USER
    nicname     = var.nics[1]["name"]
    ssh         = var.DEVOPS_AZURE_PUBLIC_SSH
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
    rg          = var.rg_name
    Location    = var.rg_location
    sise        = "Standard_DS1_v2"
    adminuser   = var.DEVOPS_AZURE_ADMIN_USER
    nicname     = var.nics[2]["name"]
    ssh         = var.DEVOPS_AZURE_PUBLIC_SSH
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