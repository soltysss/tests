


resource "random_password" "sql_user" {
  length = 16
}

resource "google_sql_user" "default" {
  name     = "${var.cloudsql_database_user}"
  password = "${random_password.sql_user.result}"
  instance = "${var.cloudsql_instance_name}"
  host     = "%"
}

resource "google_sql_database" "default" {
  name     = "${var.cloudsql_database_name}"
  instance = "${var.cloudsql_instance_name}"
  charset  = "utf8"
}