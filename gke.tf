# GKE cluster
resource "google_container_cluster" "gke_cluster" {
  name               = var.gke_name
  location           = var.zone
  network            = google_compute_network.vpc.id
  subnetwork         = google_compute_subnetwork.subnet.id 
  initial_node_count = var.node_count

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.4.0.0/21" 
    services_ipv4_cidr_block = "10.8.0.0/22"  
  }

  # Enable network policy
  network_policy {
    enabled = true
  }

# GKE cluster master authorized networks
master_authorized_networks_config {
    cidr_blocks {
        cidr_block   = var.subnet_ip_range
        display_name = "Allow"
    }
}

# GKE default node pool
node_config {
    machine_type = var.general_workload_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

}

# Node pool for general workloads
resource "google_container_node_pool" "general_workload_node_pool" {
  name               = "general-workload-pool"
  location           = var.zone  
  cluster            = google_container_cluster.gke_cluster.name
  initial_node_count = var.general_workload_node_count  

  node_config {
    machine_type = var.general_workload_machine_type  
    disk_size_gb = var.disk_size_gb 
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_upgrade = true  
    auto_repair   = true
  }
}

# Node pool for CPU-intensive workloads
resource "google_container_node_pool" "cpu_intensive_node_pool" {
  name               = "cpu-intensive-pool"
  location           = var.zone  
  cluster            = google_container_cluster.gke_cluster.name
  initial_node_count = var.cpu_intensive_node_count  

  node_config {
    machine_type = var.cpu_intensive_machine_type  
    disk_size_gb = var.disk_size_gb 
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_upgrade = true  
    auto_repair   = true 
  }
}