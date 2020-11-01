data "google_service_account" "agent" {
  account_id = var.agent_service_account_id
  project    = var.project
}

data "local_file" "redirect_on_shutdown_script" {
  filename = "${path.module}/scripts/redirect_on_shutdown.py"
}

resource "google_compute_instance_template" "agent" {
  name_prefix    = "drone-${local.installation_id}-agent-template-"
  machine_type   = var.agent_machine_type
  can_ip_forward = false

  # Boot disk
  disk {
    source_image = data.google_compute_image.ubuntu_1804.self_link
    boot         = true
  }

  # 2 Local SSD disks (2 x 375 GB, see https://cloud.google.com/compute/docs/disks/local-ssd)
  # Drone Agent needs a lot of memory because of Docker images cache
  # We decided to use additional flash memory Local SSD, it will be mounted to `/var/lib/docker`
  # Scratch disk is suitable for storing Docker cache
  # We specified NVMe interface due to the best performance
  disk {
    disk_type = "local-ssd"
    type      = "SCRATCH"
    interface = "NVME"
    # NOTE: Disk size for Local SSD must be exactly 375 GB
    disk_size_gb = 375
  }
  disk {
    disk_type    = "local-ssd"
    type         = "SCRATCH"
    interface    = "NVME"
    disk_size_gb = 375
  }

  network_interface {
    subnetwork = google_compute_subnetwork.drone_subnetwork.self_link
    access_config {
    }
  }

  labels = var.compute_extra_labels
  tags   = [local.drone_node_firewall_tag]

  metadata = {
    ssh-keys = "${local.ssh_user}:${local.ssh_public_key}"
    shutdown-script = templatefile("${path.module}/scripts/agents_shutdown.sh.tmpl", {
      drone_primary_admin_token = local.drone_primary_admin_token
      drone_rpc_host            = local.hostname
    })

  }

  service_account {
    email  = data.google_service_account.agent.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = templatefile("${path.module}/scripts/agents_startup.sh.tmpl", {
    drone_primary_admin_token      = local.drone_primary_admin_token
    drone_rpc_host                 = local.hostname
    drone_rpc_secret               = local.drone_rpc_secret
    gcs_bucket_folder_with_secrets = var.gcs_bucket_folder_with_secrets
    drone_runner_version           = var.drone_runner_version
    runner_capacity                = var.runner_capacity
    redirect_on_shutdown_script    = data.local_file.redirect_on_shutdown_script.content
  })

  lifecycle {
    create_before_destroy = true
  }

}

resource "google_compute_instance_group_manager" "agents" {
  name               = local.agents_group_manager_name
  description        = "Compute VM Instance Group for autoscaling Drone Agent"
  zone               = var.zone
  base_instance_name = "drone-${local.installation_id}-agent"
  version {
    instance_template = google_compute_instance_template.agent.id
  }
}

resource "google_compute_autoscaler" "agents" {
  name   = "drone-${local.installation_id}-agents-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.agents.id

  autoscaling_policy {
    max_replicas    = var.autoscaling_max_replicas
    min_replicas    = var.autoscaling_min_replicas
    cooldown_period = var.autoscaling_cooldown_period
    cpu_utilization {
      target = var.autoscaling_cpu_utilization
    }
  }
}
