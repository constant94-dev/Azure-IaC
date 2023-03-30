output "source_image_reference" {
  description = "SourceImageReference of the virtual machine."
  value = azurerm_linux_virtual_machine.vm.source_image_reference
}

output "name" {
  description = "Name of the virtual machine."
  value = azurerm_linux_virtual_machine.vm.name
}

output "admin_username" {
  description = "admin username of the virtual machine."
  value = azurerm_linux_virtual_machine.vm.admin_username
}

output "network_interface_ids_id" {
  description = "Network interface ids set on the virtual machine."
  value = azurerm_linux_virtual_machine.vm.network_interface_ids
}

output "os_disk" {
  description = "OS disk of the virtual machine."
  value = azurerm_linux_virtual_machine.vm.os_disk
}