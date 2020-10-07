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
        automount_service_account_token = true
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
        }
      }
    }
  }
}