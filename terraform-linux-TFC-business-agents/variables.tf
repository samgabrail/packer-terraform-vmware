#===========================#
# VMware vCenter connection #
#===========================#

variable "vsphere-user" {
  type        = string
  description = "VMware vSphere user name"
}

variable "vsphere-password" {
  type        = string
  description = "VMware vSphere password"
}

variable "vsphere-vcenter" {
  type        = string
  description = "VMWare vCenter server FQDN / IP"
}

variable "vsphere-unverified-ssl" {
  type        = string
  description = "Is the VMware vCenter using a self signed certificate (true/false)"
}

variable "vsphere-datacenter" {
  type        = string
  description = "VMWare vSphere datacenter"
}

variable "vsphere-cluster" {
  type        = string
  description = "VMWare vSphere cluster"
  default     = ""
}

variable "vsphere-template-folder" {
  type        = string
  description = "Template folder"
  default = "Templates"
}

#================================#
# VMware vSphere virtual machine #
#================================#

variable "master-count" {
  description = "Number of Master VMs"
  default     =  1
}

variable "master-name" {
  type        = string
  description = "The name of the vSphere master virtual machines and the hostname of the machine"
}

variable "worker-count" {
  description = "Number of Worker VMs"
  default     =  2
}

variable "worker-name" {
  type        = string
  description = "The name of the vSphere worker virtual machines and the hostname of the machine"
}

variable "vm-name-prefix" {
  type        = string
  description = "Name of VM prefix"
  default     =  "k3sup"
}

variable "vm-datastore" {
  type        = string
  description = "Datastore used for the vSphere virtual machines"
}

variable "vm-network" {
  type        = string
  description = "Network used for the vSphere virtual machines"
}

variable "vm-linked-clone" {
  type        = string
  description = "Use linked clone to create the vSphere virtual machine from the template (true/false). If you would like to use the linked clone feature, your template need to have one and only one snapshot"
  default     = "false"
}

variable "master-cpu" {
  description = "Number of vCPU for the vSphere master virtual machines"
  default     = 2
}

variable "master-ram" {
  description = "Amount of RAM for the vSphere master virtual machines (example: 2048)"
}

variable "worker-cpu" {
  description = "Number of vCPU for the vSphere worker virtual machines"
  default     = 2
}

variable "worker-ram" {
  description = "Amount of RAM for the vSphere worker virtual machines (example: 2048)"
}

variable "vm-guest-id" {
  type        = string
  description = "The ID of virtual machines operating system"
}

variable "vm-template-master-name" {
  type        = string
  description = "The master template to clone to create the VM"
}

variable "vm-template-worker-name" {
  type        = string
  description = "The worker template to clone to create the VM"
}

variable "vm-domain" {
  type        = string
  description = "Linux virtual machine domain name for the machine. This, along with host_name, make up the FQDN of the virtual machine"
  default     = ""
}
