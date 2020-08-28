variable "vsphere_user" {}

variable "vsphere_password" {}

variable "vsphere_server" {}

variable "windows_template" {
    default = "Win2019-Template-Base-Thick"
}

variable "computer_name" {
    default = "machine"
}