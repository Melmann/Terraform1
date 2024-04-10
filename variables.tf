variable "resource_group_location" {
  default     = "uksouth"
  description = "Location of the resource group."
}

variable "prefix" {
  type        = string
  default     = "VM-WIN-IIS"
  description = "Prefix of the resource name"
}