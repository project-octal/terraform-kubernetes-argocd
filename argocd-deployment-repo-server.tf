resource "kubernetes_deployment" "argocd_repo_server" {
  metadata {
    name      = "argocd-repo-server"
    namespace = kubernetes_namespace.argocd_namespace.metadata.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-repo-server"
      "app.kubernetes.io/component" : "repo-server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        "app.kubernetes.io/name" : "argocd-repo-server"
      }
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : "argocd-repo-server"
        }, var.labels)
      }
      spec {
        affinity {
          pod_anti_affinity {
            preferred_during_scheduling_ignored_during_execution {
              weight = 100
              pod_affinity_term {
                topology_key = "failure-domain.beta.kubernetes.io/zone"
                label_selector {
                  match_labels = {
                    "app.kubernetes.io/name" : "argocd-repo-server"
                  }
                }
              }
            }
            required_during_scheduling_ignored_during_execution {
              topology_key = "kubernetes.io/hostname"
              label_selector {
                match_labels = {
                  "app.kubernetes.io/name" : "argocd-repo-server"
                }
              }
            }
          }
        }
        automount_service_account_token = false
        container {
          name              = "argocd-repo-server"
          image             = "${var.image_repository}/${var.argocd_repo_image}:${var.argocd_version}"
          image_pull_policy = var.image_pull_policy
          command           = ["uid_entrypoint.sh", "argocd-repo-server", "--redis", "argocd-redis-ha-haproxy:6379"]
          # TODO: Add these!
          resources {}
          liveness_probe {}
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