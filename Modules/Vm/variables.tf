variable "prefix" {
  type        = string
  default     = "win-vm-iis"
  description = "Prefix of the resource name"
}
variable "my_terraform_nic_id" {
  type        = string
  default     = "win-vm-iis"
  description = "Prefix of the resource name"
}

variable "resource_g" {
  description = "resource group name ."
  type        = string
}

variable "rg_location" {
  description = "resource group location"
  type        = string
}