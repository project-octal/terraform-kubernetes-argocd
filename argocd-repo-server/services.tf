
resource "kubernetes_service" "argocd_repo_server" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    port {
      name        = "server"
      protocol    = "TCP"
      port        = 8081
      target_port = 8081
    }
    port {
      name        = "metrics"
      protocol    = "TCP"
      port        = 8084
      target_port = 8084
    }
    selector = {
      "app.kubernetes.io/name" : var.name
    }
  }
}