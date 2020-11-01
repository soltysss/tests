
resource "kubernetes_namespace" "drone" {
  metadata {
    name = "${var.drone_k8s_namespace}"
  }
}

resource "kubernetes_cluster_role_binding" "drone" {
  metadata {
    name = "drone"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "${kubernetes_namespace.drone.metadata.0.name}"
  }
}

resource "kubernetes_deployment" "drone" {
  metadata {
    namespace = "${kubernetes_namespace.drone.metadata.0.name}"
    name      = "drone"
    labels = {
      app = "drone"
    }
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "drone"
      }
    }

    template {
      metadata {
        labels = {
          app = "drone"
        }
      }

      spec {
        # Mount the "default" service account token for Drone Job Sheduller
        # see https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server
        automount_service_account_token = true

        container {
          name  = "drone"
          image = "drone/drone:1.2"
          env {
            name  = "DRONE_KUBERNETES_ENABLED"
            value = "true"
          }
          env {
            name = "DRONE_KUBERNETES_NAMESPACE"
            value = "${var.drone_k8s_namespace}"
          }
          env {
            name  = "DRONE_KUBERNETES_SERVICE_ACCOUNT"
            value = "default"
          }
          env {
            name  = "DRONE_GITHUB_SERVER"
            value = "https://github.com"
          }
          env {
            name  = "DRONE_GITHUB_CLIENT_ID"
            value = "${var.drone_github_client_id}"
          }
          env {
            name  = "DRONE_GITHUB_CLIENT_SECRET"
            value = "${var.drone_github_client_secret}"
          }
          env {
            name  = "DRONE_RPC_SECRET"
            value = "${var.drone_rpc_secret}"
          }
          env {
            name  = "DRONE_SERVER_HOST"
            value = "${local.drone_server_host}"
          }
          env {
            name  = "DRONE_SERVER_PROTO"
            value = "https"
          }
          env {
            name = "DRONE_DATABASE_DRIVER"
            value = "mysql"
          }
          env {
            name = "DRONE_DATABASE_DATASOURCE"
            value = "${var.cloudsql_database_user}:${random_password.sql_user.result}@tcp(${var.cloudsql_private_ip}:3306)/${var.cloudsql_database_name}?timeout=1s"
          }
          env {
            name  = "DRONE_USER_CREATE"
            value = "username:maratkomarov,admin:true"
          }
          port {
            container_port = 443
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "drone" {
  metadata {
    namespace = "${kubernetes_namespace.drone.metadata.0.name}"
    name      = "drone"
  }
  spec {
    type             = "NodePort"
    session_affinity = "ClientIP"
    selector = {
      app = "${kubernetes_deployment.drone.metadata.0.labels.app}"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}


resource "kubernetes_ingress" "drone" {
  metadata {
    namespace = "${kubernetes_namespace.drone.metadata.0.name}"
    name      = "drone"

    # 2019-07-31:
    # Managed Certificate resource (https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs)
    # is not yet implemented in Terraform.
    # Use Shared SSL certificate approach, suggested in
    # https://github.com/terraform-providers/terraform-provider-kubernetes/issues/446#issuecomment-496905302
    annotations = {
      "ingress.gcp.kubernetes.io/pre-shared-cert"   = "${google_compute_managed_ssl_certificate.default.name}"
      "kubernetes.io/ingress.global-static-ip-name" = "${google_compute_global_address.default.name}"
      "kubernetes.io/ingress.allow-http"            = "false"
    }
  }
  spec {
    rule {
      http {
        path {
          backend {
            service_name = "${kubernetes_service.drone.metadata.0.name}"
            service_port = 80
          }
        }
      }
    }
  }
}