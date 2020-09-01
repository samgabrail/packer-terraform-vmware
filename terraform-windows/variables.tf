variable "vsphere_user" {}

variable "vsphere_password" {}

variable "vsphere_server" {}

variable "windows_template" {
    default = "Win2019-Template-Base-Thick"
}

variable "computer_name" {
    default = "machine"
}

variable "vm-count" {
    default = 1
}

variable "vm-name" {
  type        = string
  description = "The name of the vSphere virtual machines and the hostname of the machine"
}

variable "vm-cpu" {
  type        = string
  description = "Number of vCPU for the vSphere virtual machines"
  default     = "2"
}

variable "vm-ram" {
  type        = string
  description = "Amount of RAM for the vSphere virtual machines (example: 2048)"
}