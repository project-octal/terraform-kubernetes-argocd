resource "kubernetes_deployment" "haproxy_deployment" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    replicas               = var.replicas
    revision_history_limit = 1
    selector {
      match_labels = {
        "app.kubernetes.io/name" : var.name
      }
    }
    strategy {
      type = "RollingUpdate"
    }
    template {
      metadata {
        name = var.name
        labels = merge({
          "app.kubernetes.io/name" : var.name
        }, local.labels)
        annotations = {
          "checksum/config" : var.checksum-config
        }
      }
      spec {
        service_account_name            = kubernetes_service_account.haproxy_service_account.metadata.0.name
        automount_service_account_token = true
        security_context {
          run_as_non_root = true
          fs_group        = 1000
          run_as_user     = 1000
        }
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
          name              = "haproxy"
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8888
            }
            initial_delay_seconds = 5
            period_seconds        = 3
          }
          readiness_probe {
            http_get {
              path = "/healthz"
              port = 8888
            }
            initial_delay_seconds = 5
            period_seconds        = 30
          }
          port {
            name           = "redis"
            container_port = 6379
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
          volume_mount {
            name       = "service-token"
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount/"
            read_only  = true
          }
          volume_mount {
            name       = "data"
            mount_path = "/usr/local/etc/haproxy"
          }
          volume_mount {
            name       = "shared-socket"
            mount_path = "/run/haproxy"
          }
        }
        init_container {
          name              = "config-init"
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          command           = ["sh"]
          args              = ["/readonly/haproxy_init.sh"]
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
          volume_mount {
            name       = "config-volume"
            mount_path = "/readonly"
            read_only  = true
          }
          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }
        volume {
          name = "config-volume"
          config_map {
            name = "argocd-redis-ha-configmap"
          }
        }
        volume {
          name = "service-token"
          secret {
            secret_name = kubernetes_service_account.haproxy_service_account.default_secret_name
          }
        }
        volume {
          name = "shared-socket"
          empty_dir {}
        }
        volume {
          name = "data"
          empty_dir {}
        }
      }
    }
  }
}