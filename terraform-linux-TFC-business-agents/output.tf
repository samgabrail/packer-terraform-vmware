output "master_ips" {
  value = {
      for vm in vsphere_virtual_machine.master:
        vm.name => vm.guest_ip_addresses[0]
  }
}

output "worker_ips" {
  value = {
      for vm in vsphere_virtual_machine.worker:
        vm.name => vm.guest_ip_addresses[0]
  }
}

