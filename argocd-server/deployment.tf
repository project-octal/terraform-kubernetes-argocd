resource "kubernetes_deployment" "server_deployment" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        "app.kubernetes.io/name" : var.name
      }
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : var.name
        }, var.labels)
      }
      spec {
        service_account_name            = kubernetes_service_account.server_service_account.metadata.0.name
        automount_service_account_token = false
        affinity {
          pod_anti_affinity {
            preferred_during_scheduling_ignored_during_execution {
              weight = 100
              pod_affinity_term {
                topology_key = var.pod_affinity_topology_key
                label_selector {
                  match_labels = {
                    "app.kubernetes.io/name" : var.name
                  }
                }
              }
            }
            required_during_scheduling_ignored_during_execution {
              topology_key = "kubernetes.io/hostname"
              label_selector {
                match_labels = {
                  "app.kubernetes.io/name" : var.name
                }
              }
            }
          }
        }
        container {
          name              = var.name
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          command           = ["argocd-server", "--staticassets", "/shared/app", "--redis", "${var.redis_address}:${var.redis_port}"]
          env {
            name  = "ARGOCD_API_SERVER_REPLICAS"
            value = tostring(var.replicas)
          }
          env {
            name  = "ARGOCD_MAX_CONCURRENT_LOGIN_REQUESTS_COUNT"
            value = "0"
          }
          port {
            container_port = 8080
          }
          port {
            container_port = 8083
          }
          resources {
            requests {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
            limits {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
          }
          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
          readiness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 3
            period_seconds        = 30
          }
          volume_mount {
            name       = "service-token"
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount/"
            read_only  = true
          }
          volume_mount {
            name       = "ssh-known-hosts"
            mount_path = "/app/config/ssh"
          }
          volume_mount {
            name       = "tls-certs"
            mount_path = "/app/config/tls"
          }
        }
        volume {
          name = "service-token"
          secret {
            secret_name = kubernetes_service_account.server_service_account.default_secret_name
          }
        }
        volume {
          name = "static-files"
          empty_dir {}
        }
        volume {
          name = "ssh-known-hosts"
          config_map {
            name = "argocd-ssh-known-hosts-cm"
          }
        }
        volume {
          name = "tls-certs"
          config_map {
            name = "argocd-tls-certs-cm"
          }
        }
      }
    }
  }
}