// output "ipv4" {
//   value = vsphere_virtual_machine.vm.guest_ip_addresses[0]
// }
// output "ipv6" {
//   value = vsphere_virtual_machine.vm.guest_ip_addresses[1]
// }

output "ipv4" {
  value = {
      for vm in vsphere_virtual_machine.vm:
      vm.name => vm.guest_ip_addresses[0]
  }
}

output "ipv6" {
  value = {
      for vm in vsphere_virtual_machine.vm:
      vm.name => vm.guest_ip_addresses[1]
  }
}