resource "kubernetes_deployment" "argocd_application_controller" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }

  spec {

    selector {
      match_labels = {
        "app.kubernetes.io/name" : var.name
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : var.name
        }, var.labels)
      }
      spec {
        service_account_name            = kubernetes_service_account.argocd_application_controller.metadata.0.name
        automount_service_account_token = false
        # TODO: Add this!
        # security_context {}
        container {
          name              = var.name
          image             = "${var.image_repository}/${var.argocd_image}:${var.argocd_version}"
          image_pull_policy = var.image_pull_policy
          command = [
            var.name,
            "--status-processors",
            "20",
            "--operation-processors",
            "10",
            "--repo-server-timeout-seconds",
            "300",
            "--redis",
            "${var.redis_address}:${var.redis_port}"
          ]
          # TODO: Resource requirements will need to be declared
          resources {}
          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8082
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          readiness_probe {
            http_get {
              path = "/healthz"
              port = 8082
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          port {
            container_port = 8082
          }
          volume_mount {
            name       = "service-token"
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount/"
            read_only  = true
          }
        }
        volume {
          name = "service-token"
          secret {
            secret_name = kubernetes_service_account.argocd_application_controller.default_secret_name
          }
        }
      }
    }
  }
}