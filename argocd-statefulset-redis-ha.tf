resource "kubernetes_stateful_set" "argocd_redis_ha" {
  metadata {
    name = "argocd-redis-ha"
    labels = merge({
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "app.kubernetes.io/component" : "redis"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    pod_management_policy = "OrderedReady"
    update_strategy {
      type = "RollingUpdate"
    }
    replicas     = 3
    service_name = "argocd-redis-ha"
    selector {
      match_labels = {
        "app.kubernetes.io/name" : "argocd-redis-ha"
      }
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : "argocd-redis-ha"
        }, var.labels)
        annotations = {
          "checksum/init-config" : "552ee3bec8fe5d9d865e371f7b615c6d472253649eb65d53ed4ae874f782647c"
        }
      }
      spec {
        service_account_name = kubernetes_service_account.argocd_redis_ha.metadata.0.name
        affinity {
          pod_anti_affinity {
            preferred_during_scheduling_ignored_during_execution {
              weight = 100
              pod_affinity_term {
                topology_key = "failure-domain.beta.kubernetes.io/zone"
                label_selector {
                  match_labels = {
                    "app.kubernetes.io/name" : "argocd-redis-ha"
                  }
                }
              }
            }
            required_during_scheduling_ignored_during_execution {
              topology_key = "kubernetes.io/hostname"
              label_selector {
                match_labels = {
                  "app.kubernetes.io/name" : "argocd-redis-ha"
                }
              }
            }
          }
        }
        security_context {
          run_as_non_root = var.redis_run_as_non_root
          fs_group        = var.redis_fs_group
          run_as_user     = var.redis_run_as_user
        }

        init_container {
          name              = "config-init"
          image             = "${var.image_repository}/${var.redis_image}:${var.redis_version}"
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
          # TODO: Add these!
          resources {}
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
          image             = "${var.image_repository}/${var.redis_image}:${var.redis_version}"
          image_pull_policy = var.image_pull_policy
          command           = ["redis-server"]
          args              = ["/data/conf/redis.conf"]
          # TODO: Add these!
          resources {}
          liveness_probe {
            initial_delay_seconds = 15
            tcp_socket {
              port = 6379
            }
          }
          readiness_probe {}
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
          image             = "${var.image_repository}/${var.redis_image}:${var.redis_version}"
          image_pull_policy = var.image_pull_policy
          command           = ["redis-sentinel"]
          args              = ["/data/conf/sentinel.conf"]
          # TODO: Add these!
          resources {}
          liveness_probe {
            initial_delay_seconds = 15
            tcp_socket {
              port = 26379
            }
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