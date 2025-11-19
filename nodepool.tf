resource "google_container_node_pool" "primary_pool" {
  name       = var.node_pool_name
  cluster    = google_container_cluster.private_cluster.name
  location   = var.zone
  node_count = var.node_count

  node_config {
    machine_type = "e2-small"
    disk_type    = "pd-standard"
    disk_size_gb = 20

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }

    tags = ["gke-node"]
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}

