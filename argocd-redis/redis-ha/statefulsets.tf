resource "kubernetes_stateful_set" "argocd_redis_ha" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    pod_management_policy = "OrderedReady"
    update_strategy {
      type = "RollingUpdate"
    }
    replicas     = var.replicas
    service_name = var.name
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
        annotations = {
          "checksum/init-config" : var.checksum-init-config
        }
      }
      spec {
        service_account_name = kubernetes_service_account.redis_ha_service_account.metadata.0.name
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
        security_context {
          run_as_non_root = true
          fs_group        = 1000
          run_as_user     = 1000
        }

        init_container {
          name              = "config-init"
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          command           = ["sh"]
          args              = ["/readonly-config/init.sh"]
          env {
            name  = "SENTINEL_ID_0"
            value = "25b71bd9d0e4a51945d8422cab53f27027397c12"
          }
          env {
            name  = "SENTINEL_ID_1"
            value = "896627000a81c7bdad8dbdcffd39728c9c17b309"
          }
          env {
            name  = "SENTINEL_ID_2"
            value = "3acbca861108bc47379b71b1d87d1c137dce591f"
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
          volume_mount {
            name       = "config"
            mount_path = "/readonly-config"
            read_only  = true
          }
          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }

        container {
          name              = "redis"
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          command           = ["redis-server"]
          args              = ["/data/conf/redis.conf"]
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
            tcp_socket {
              port = 6379
            }
            initial_delay_seconds = 15
            period_seconds        = 5
          }
          readiness_probe {
            tcp_socket {
              port = 6379
            }
            initial_delay_seconds = 15
            period_seconds        = 5
          }
          port {
            name           = "redis"
            container_port = 6379
          }
          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }

        container {
          name              = "sentinel"
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          command           = ["redis-sentinel"]
          args              = ["/data/conf/sentinel.conf"]
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
          readiness_probe {
            tcp_socket {
              port = 26379
            }
            initial_delay_seconds = 15
            period_seconds        = 5
          }
          liveness_probe {
            tcp_socket {
              port = 26379
            }
            initial_delay_seconds = 15
          }
          port {
            name           = "sentinel"
            container_port = 26379
          }
          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }
        volume {
          name = "config"
          config_map {
            name = "argocd-redis-ha-configmap"
          }
        }
        volume {
          name = "data"
          empty_dir {}
        }
      }
    }
  }
}