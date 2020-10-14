provider "vsphere" {
  version = "1.23.0"
  vim_keep_alive = 30
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "Datacenter" 
}

data "vsphere_datastore" "datastore" {
  name          = "Datastore2_NonSSD" 
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Cluster01" 
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name = var.windows_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  count = var.vm-count

  name             = "${var.vm-name}-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
 # host_system_id = "${data.vsphere_datacenter.dc.id}"
  
  num_cpus = var.vm-cpu
  memory   = var.vm-ram
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  wait_for_guest_net_timeout = -1
  
  network_interface {
    network_id = data.vsphere_network.network.id
	  adapter_type = "vmxnet3"
  }

  disk {
    name = "machine.vmdk"
    thin_provisioned = false
    eagerly_scrub = true
    size = data.vsphere_virtual_machine.template.disks.0.size
  }

  disk {
    name = "machine_1.vmdk"
    unit_number = 1
    thin_provisioned = false
    eagerly_scrub = true
    size = data.vsphere_virtual_machine.template.disks.0.size
  }
  
  clone {
      template_uuid = data.vsphere_virtual_machine.template.id
    
    customize {
      windows_options {
        computer_name = "node-${count.index + 1}"
        workgroup     = "test"
      }
      network_interface {}
      timeout = 30

    }
    
  }
}

		