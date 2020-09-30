resource "kubernetes_service" "haproxy_service" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
    annotations = null
  }
  spec {
    port {
      name        = "haproxy"
      protocol    = "TCP"
      port        = 6379
      target_port = "redis"
    }
    selector = {
      "app.kubernetes.io/name" : var.name
    }
  }
}