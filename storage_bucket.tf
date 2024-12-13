resource "google_storage_bucket" "state_bucket" {
  name          = var.bucket_name
  location      = var.bucket_location
  storage_class = var.storage_class

  versioning {
    enabled = var.enable_versioning
  }
}
