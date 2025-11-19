output "project_id" {
  value = var.project_id
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "subnet_name" {
  value = google_compute_subnetwork.private_subnet.name
}

output "cluster_name" {
  value = google_container_cluster.private_cluster.name
}

output "cluster_endpoint" {
  value       = google_container_cluster.private_cluster.endpoint
  description = "Public endpoint for the cluster control plane (may be empty if master is private)."
}

