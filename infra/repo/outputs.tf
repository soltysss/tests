output "site_url" {
  description = "Base URL to repository"
  value       = "http://${google_storage_bucket.default.name}"
}

output "gs_scalarizr_upload_url" {
  description = "Base upload URL for gsutil (ci_settings.remote.dev_storage in .drone.yml)"
  value       = "gs://${google_storage_bucket.default.name}/scalarizr"
}

output "gs_terraform_providers_upload_url" {
  description = "Base upload URL for gsutil to publish Scalr distributed terraform providers"
  value       = "gs://${google_storage_bucket.default.name}/terraform-providers"
}

