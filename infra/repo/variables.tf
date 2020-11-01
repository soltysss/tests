variable "hostname" {
  description = <<EOF
The [hostname].scalr-labs.net of a repository.

The service account email, you're using to run this template, should be Verified owner of scalr-labs.net
See https://www.google.com/webmasters/verification

The 'Error 403: The bucket you tried to create is a domain name owned by another user'
on google_storage_bucket.repo creation means you need to handle the step above.
EOF
}

variable "dns_zone_name" {
  default = "scalr-labs-net"
}

variable "region" {
  default = "us-west1"
}
