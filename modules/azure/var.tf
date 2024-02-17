
variable "rg_location" {
  description = "Location/Region of Resources"
  type        = string
  default     = "East US"
}

variable "rg_name" {
  description = "Namge of resource group"
  type        = string
  default     = "lab_vm"
}

variable "vnet_name" {
  description = "Namge of Virtual Network"
  type        = string
  default     = "vm-linux-vnet"
}

variable "vnet_address_space" {
  description = "Address space of Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Namge of Subnet"
  type        = string
  default     = "vm-linux-subnet"
}

variable "subnet_address_prefix" {
  description = "Prefix of Subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_ip" {
  description = "Prefix of Subnet"
  type        = string
  default     = "10.0.2.0/24"
}
