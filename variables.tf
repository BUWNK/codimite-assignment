############################## Cloud Storage ############################## 

# Name of the Google Cloud Storage bucket
variable "bucket_name" {
  description = "name of the Google Cloud Storage bucket."
  type        = string
}

# The region 
variable "bucket_location" {
  description = "The region"
  type        = string
  default     = "asia-east1"
}

# The storage class
variable "storage_class" {
  description = "The storage class"
  type        = string
  default     = "STANDARD" 
}

# Versioning
variable "enable_versioning" {
  description = "Flag to enable versioning"
  type        = bool
  default     = true 
}



############################## VPC ############################## 

# VPC name
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "codimite-vpc"
}

# Define the name of the subnet
variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "codimite-subnet-1"
}

# Define the CIDR range for the subnet
variable "subnet_ip_range" {
  description = "IP range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

# Define the region for the subnet
variable "subnet_region" {
  description = "Region for the subnet"
  type        = string
  default     = "asia-east1"
}




############################## GKE ############################## 

# GKE cluster Name
variable "gke_name" {
  description = "Name of the GKE"
  type        = string
  default     = "codimite-gke"
}

# Zone for the GKE cluster
variable "zone" {
  description = "The zone of the GKE cluster and node pools"
  type        = string
  default     = "asia-east1-a"
}

# initial_node_count for the GKE cluster
variable "node_count" {
  description = "The initial node count for the GKE cluster"
  type        = string
  default     = 1
}


# Machine type for general workloads
variable "general_workload_machine_type" {
  description = "Machine type for general workloads"
  type        = string
  default     = "e2-medium"
}

# Machine type for CPU-intensive workloads
variable "cpu_intensive_machine_type" {
  description = "Machine type for CPU-intensive workloads"
  type        = string
  default     = "n2-highcpu-4"
}

# Number of nodes for the general workload node pool
variable "general_workload_node_count" {
  description = "Initial node count"
  type        = number
  default     = 2
}

# Number of nodes for the CPU-intensive workload node pool
variable "cpu_intensive_node_count" {
  description = "Initial node count for the CPU-intensive workload node pool"
  type        = number
  default     = 2
}

# Ddisk size for the node pools (GB)
variable "disk_size_gb" {
  description = "Disk size for the node pools"
  type        = number
  default     = 60
}
