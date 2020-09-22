resource "kubernetes_deployment" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-server"
      "app.kubernetes.io/component" : "server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        "app.kubernetes.io/name" : "argocd-server"
      }
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : "argocd-server"
        }, var.labels)
      }
      spec {
        service_account_name = kubernetes_service_account.argocd_server.metadata.0.name
        affinity {
          pod_anti_affinity {
            preferred_during_scheduling_ignored_during_execution {
              weight = 100
              pod_affinity_term {
                topology_key = "failure-domain.beta.kubernetes.io/zone"
                label_selector {
                  match_labels = {
                    "app.kubernetes.io/name" : "argocd-server"
                  }
                }
              }
            }
            required_during_scheduling_ignored_during_execution {
              topology_key = "kubernetes.io/hostname"
              label_selector {
                match_labels = {
                  "app.kubernetes.io/name" : "argocd-server"
                }
              }
            }
          }
        }
        container {
          name              = "argocd-server"
          image             = "${var.image_repository}/${var.argocd_server_image}:v${var.argocd_version}"
          image_pull_policy = var.image_pull_policy
          command           = ["argocd-server", "--staticassets", "/shared/app", "--redis", "argocd-redis-ha-haproxy:6379"]
          env {
            name  = "ARGOCD_API_SERVER_REPLICAS"
            value = "2"
          }
          port {
            container_port = 8080
          }
          port {
            container_port = 8083
          }
          # TODO: Add these!
          resources {}
          liveness_probe {}
          readiness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 3
            period_seconds        = 30
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