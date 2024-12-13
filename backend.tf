terraform {
  backend "gcs" {
    bucket  = "codimite-storage-bucket"  
    prefix  = "terraform/state"                                    
  }
}
