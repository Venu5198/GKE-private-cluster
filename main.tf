terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "kxnwork"
  region  = "us-central1"
  zone    = "us-central1-a"
}

# ---------------------------
# 1. VPC Network
# ---------------------------
resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = false
}

# ---------------------------
# 2. Private Subnet
# ---------------------------
resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
}

# ---------------------------
# 3. Cloud Router
# ---------------------------
resource "google_compute_router" "router" {
  name    = "kxnwork-router"
  region  = "us-central1"
  network = google_compute_network.vpc.id
}

# ---------------------------
# 4. Cloud NAT
# ---------------------------
resource "google_compute_router_nat" "nat" {
  name                               = "my-nat"
  region                             = "us-central1"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# ---------------------------
# 5. Firewall for IAP SSH
# ---------------------------
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-iap"]
}

# ---------------------------
# 6. Private VM (no external IP)
# ---------------------------
resource "google_compute_instance" "private_vm" {
  name         = "private-vm-1"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  tags         = ["allow-iap"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.id
    # NO access_config => no external IP
  }

  metadata = {
    block-project-ssh-keys = "false"
  }
}

