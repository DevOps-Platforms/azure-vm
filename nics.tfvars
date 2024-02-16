nics = {

    1 = {
    name             = "nic-jump-box"
    location         = var.rg_location
    rg               = var.rg_name
    ipconfigname     = "internal"
    subnetid         = var.subnet_name
    privip           = "Dynamic"
    privip           = var.public_ip
    }

    2 = { 
    name             = "nic-0"
    location         = var.rg_location
    rg               = var.rg_name
    ipconfigname     = "internal"
    subnetid         = var.subnet_name
    privip           = "Dynamic"
    privip           = null
   }

   3 = { 
    name             = "nic-1"
    location         = var.rg_location
    rg               = var.rg_name
    ipconfigname     = "internal"
    subnetid         = var.subnet_name
    privip           = "Dynamic"
    privip           = null
   }
}