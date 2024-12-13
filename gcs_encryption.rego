package main

# Deny if encryption is not specified in GCS buckets
deny[msg] {
  input.resource_type == "google_storage_bucket"
  not input.values.encryption.default_kms_key_name
  msg = sprintf("GCS bucket '%s' must specify a default KMS key for encryption.", [input.values.name])
}

# Deny if the project is not explicitly set
deny[msg] {
  input.resource_type == "google_storage_bucket"
  not input.values.project
  msg = sprintf("GCS bucket '%s' must specify a project.", [input.values.name])
}
