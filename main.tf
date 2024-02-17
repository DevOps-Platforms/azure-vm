
provider "azurerm" {
  features {}
}

module "azure" {
  source = "./modules/azure/"
  DEVOPS_AZURE_ADMIN_USER = var.DEVOPS_AZURE_ADMIN_USER
  DEVOPS_AZURE_PUBLIC_SSH = var.DEVOPS_AZURE_PUBLIC_SSH
  vms            = var.vms
  nics           = var.nics
  ips            = var.ips
}

variable "vms" {
  type = map(object({
    name                  = string
    rg                    = string
    location              = string
    size                  = string
    adminuser             = string
    nicname               = string
    ssh                   = string 
    caching               = string
    diskgb                = number
    diskname              = string
    storagetipe           = string
    publisher             = string
    offer                 = string
    sku                   = string
    version               = string
    
  }))
}

variable "nics" {
  type = map(object({
    name         = string
    location     = string
    rg           = string
    ipconfigname = string
    subnetid     = string
    privip       = string
    pubip        = string
  }))
}

variable "ips" {
  type = map(object({
    name     = string
    location = string
    rg       = string
    method   = string
    sku      = string
  }))
}

