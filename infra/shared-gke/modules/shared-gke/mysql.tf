resource "google_sql_database_instance" "shared" {
  provider         = google-beta
  name             = var.database_instance_name
  region           = var.region
  database_version = "MYSQL_5_7"

  settings {
    tier = var.database_instance_type

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.default.self_link
    }

    backup_configuration {
      enabled = true
    }
  }

  depends_on = [
    # NOTE: For private IP instance setup, note that the google_sql_database_instance does not
    # actually interpolate values from google_service_networking_connection.
    # You must explicitly add a depends_on reference as shown below.
    google_service_networking_connection.mysql_private
  ]
}
