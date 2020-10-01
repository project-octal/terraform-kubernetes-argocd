resource "kubernetes_deployment" "argocd_redis" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" : var.name
      }
    }
    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" : var.name
        }
      }
      spec {
        container {
          name              = "redis"
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          args = [
            "--save",
            "",
            "--appendonly",
            "no"
          ]
          port {
            container_port = 6379
          }
        }
        security_context {
          fs_group        = 1000
          run_as_group    = 1000
          run_as_non_root = true
          run_as_user     = 1000
        }
      }
    }
  }
}