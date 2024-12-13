# VPC
resource "google_compute_network" "vpc" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

# The subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.subnet_ip_range
  region        = var.subnet_region
}

# Allow internal communication within the VPC 
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["443", "6443", "10250", "10256"]  # Kubernetes API, Kubelet, Health checks
  }

  allow {
    protocol = "icmp"  
  }

  # Allow traffic from the internal network 
  source_ranges = ["10.0.0.0/8"]

  direction = "INGRESS"
}

# Allow GKE traffic
resource "google_compute_firewall" "allow_gke" {
  name    = "allow-gke"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["443", "80"]  
  }

  allow {
    protocol = "udp"
    ports    = ["53"]  
  }

  allow {
    protocol = "tcp"
    ports    = ["8472"]  
  }

  # Allow traffic from the internal network
  source_ranges = [var.subnet_ip_range]

  direction = "INGRESS"
}

