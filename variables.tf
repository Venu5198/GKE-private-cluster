variable "project_id" {
  type    = string
  default = "kxnwork"
}

variable "region" {
  type    = string
  default = "asia-south1"
}

variable "zone" {
  type    = string
  default = "asia-south1-a"
}

variable "vpc_name" {
  type    = string
  default = "gke-private-vpc"
}

variable "subnet_name" {
  type    = string
  default = "gke-private-subnet"
}

variable "pods_range_name" {
  type    = string
  default = "pods-range"
}

variable "services_range_name" {
  type    = string
  default = "services-range"
}

variable "cluster_name" {
  type    = string
  default = "gke-private-cluster"
}

variable "node_pool_name" {
  type    = string
  default = "primary-pool"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "node_count" {
  type    = number
  default = 1
}

