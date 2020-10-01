resource "kubernetes_service" "argocd_redis" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    port {
      name        = "tcp-redis"
      port        = 6379
      target_port = 6379
    }
    selector = {
      "app.kubernetes.io/name" : var.name
    }
  }
}