resource "kubernetes_deployment" "argocd_application_controller" {
  metadata {
    name      = "argocd-application-controller"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" : "argocd-application-controller"
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : "argocd-application-controller"
        }, var.labels)
      }
      spec {
        service_account_name = kubernetes_service_account.argocd_application_controller.metadata.0.name
        # TODO: Add this!
        security_context {}
        container {
          name              = "argocd-application-controller"
          image             = "${var.image_repository}/${var.argocd_repo_image}:${var.argocd_version}"
          image_pull_policy = var.image_pull_policy
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