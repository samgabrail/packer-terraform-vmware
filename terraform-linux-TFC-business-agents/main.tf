# =================== #
# Deploying VMware VM #
# =================== #



# Connect to VMware vSphere vCenter
provider "vsphere" {
  version = "1.23.0"
  vim_keep_alive = 30
  user           = var.vsphere-user
  password       = var.vsphere-password
  vsphere_server = var.vsphere-vcenter

  # If you have a self-signed cert
  allow_unverified_ssl = var.vsphere-unverified-ssl
}

# Define VMware vSphere 
data "vsphere_datacenter" "dc" {
  name = var.vsphere-datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vm-datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere-cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm-network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template-master" {
  name          = "/${var.vsphere-datacenter}/vm/${var.vsphere-template-folder}/${var.vm-template-master-name}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template-worker" {
  name          = "/${var.vsphere-datacenter}/vm/${var.vsphere-template-folder}/${var.vm-template-worker-name}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Create Master VMs
resource "vsphere_virtual_machine" "master" {
  count = var.master-count

  name             = "${var.master-name}-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.master-cpu
  memory   = var.master-ram
  guest_id = var.vm-guest-id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "${var.master-name}-${count.index + 1}-disk"
    thin_provisioned = false
    eagerly_scrub = false
    size  = data.vsphere_virtual_machine.template-master.disks.0.size
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template-master.id
    customize {
      linux_options {
        host_name = "${var.master-name}-${count.index + 1}"
        domain    = var.vm-domain
      }     
      network_interface {}
      timeout = 30
    }
  }
}

# Create Worker VMs
resource "vsphere_virtual_machine" "worker" {
  count = var.worker-count

  name             = "${var.worker-name}-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.worker-cpu
  memory   = var.worker-ram
  guest_id = var.vm-guest-id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "${var.worker-name}-${count.index + 1}-disk"
    thin_provisioned = false
    eagerly_scrub = false
    size  = data.vsphere_virtual_machine.template-worker.disks.0.size
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template-worker.id
    customize {
      linux_options {
        host_name = "${var.worker-name}-${count.index + 1}"
        domain    = var.vm-domain
      }     
      network_interface {}
      timeout = 30
    }
  }
}

