nics = {

  1 = {
    name         = "nic-jump-box"
    location     = "East US"
    rg           = "lab_vm"
    ipconfigname = "internal"
    subnetid     = "vm-linux-subnet"
    privip       = "Dynamic"
    pubip        = "linux-jump-ip"
  }

  2 = {
    name         = "nic-0"
    location     = "East US"
    rg           = "lab_vm"
    ipconfigname = "internal"
    subnetid     = "vm-linux-subnet"
    privip       = "Dynamic"
    pubip        = null
  }

  3 = {
    name         = "nic-1"
    location     = "East US"
    rg           = "lab_vm"
    ipconfigname = "internal"
    subnetid     = "vm-linux-subnet"
    privip       = "Dynamic"
    pubip        = null
  }
}