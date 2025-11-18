output "private_vm_ip" {
  value = google_compute_instance.private_vm.network_interface[0].network_ip
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

