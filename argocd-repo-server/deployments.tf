resource "kubernetes_deployment" "argocd_repo_server" {
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
        }, local.labels)
      }
      spec {
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
        automount_service_account_token = false
        container {
          name              = var.name
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          command           = ["uid_entrypoint.sh", "argocd-repo-server", "--redis", "${var.redis_address}:${var.redis_port}"]
          env {
            name = "ARGOCD_EXEC_TIMEOUT"
            value = var.exec_timeout
          }
          resources {
            requests = {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
            limits = {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
          }
          liveness_probe {
            tcp_socket {
              port = 8081
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
          readiness_probe {
            tcp_socket {
              port = 8081
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          port {
            container_port = 8081
          }
          port {
            container_port = 8084
          }
          volume_mount {
            name       = "ssh-known-hosts"
            mount_path = "/app/config/ssh"
          }
          volume_mount {
            name       = "tls-certs"
            mount_path = "/app/config/tls"
          }
          volume_mount {
            name       = "gpg-keys"
            mount_path = "/app/config/gpg/source"
          }
          volume_mount {
            name       = "gpg-keyring"
            mount_path = "/app/config/gpg/keys"
          }
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
        volume {
          name = "gpg-keys"
          config_map {
            name = "argocd-gpg-keys-cm"
          }
        }
        volume {
          name = "gpg-keyring"
          empty_dir {}
        }
      }
    }
  }
}