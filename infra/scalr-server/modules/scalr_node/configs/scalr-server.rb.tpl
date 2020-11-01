enable_all true
product_mode :${product_mode}

# Scalr web UI URL
routing[:endpoint_scheme] = 'https'
routing[:endpoint_host] = "${endpoint_host}"

# MySQL settings
mysql[:bind_host] = "0.0.0.0"
mysql[:bind_port] = 6280

rabbitmq[:bind_host] = "0.0.0.0"
rabbitmq[:mgmt_bind_host] = "0.0.0.0"
influxdb[:bind_host] = "0.0.0.0"
influxdb[:http_bind_host] = "0.0.0.0"

# Following IPs will be whitelisted on Scalr controlled instances
app[:ip_ranges] = ["0.0.0.0/0"]

# Httpd settings
proxy[:app_upstreams] = ['0.0.0.0:6270']
web[:app_bind_host] = '0.0.0.0'
web[:app_bind_port] = 6270

# Custom CA bundle
ssl[:extra_ca_file] = "${ssl_extra_ca_file}"

# Global proxy settings
http_proxy "${http_proxy}"
no_proxy "${no_proxy}"

app[:configuration] = {
  :scalr => {
    "tf_blob" => {
        "log_level": "DEBUG"
    },
    "tf_worker" => {
        "log_level": "DEBUG",
        "default_terraform_version"=> "0.12.19",
        "terraform_images" => {
            "0.12.10" => "hashicorp/terraform:0.12.10",
            "0.12.19" => "hashicorp/terraform:0.12.19"
        }
    },
    "tf_api" => {
        "log_level": "DEBUG"
    },
  }
}

proxy[:ssl_enable] = true
proxy[:ssl_redirect] = false
proxy[:ssl_cert_path] = "${ssl_cert_path}"
proxy[:ssl_key_path] = "${ssl_key_path}"
