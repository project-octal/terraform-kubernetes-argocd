resource "kubernetes_service" "argocd_server_metrics" {
  metadata {
    name      = "${var.name}-metrics"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "${var.name}-metrics"
    }, local.labels)
  }
  spec {
    port {
      name        = "metrics"
      protocol    = "TCP"
      port        = 8083
      target_port = 8083
    }
    selector = {
      "app.kubernetes.io/name" : "${var.name}-metrics"
    }
  }
}

resource "kubernetes_service" "argocd_server" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  spec {
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 80
      target_port = "8080"
    }
    port {
      name        = "https"
      protocol    = "TCP"
      port        = 443
      target_port = 8080
    }
    selector = {
      "app.kubernetes.io/name" : var.name
    }
  }
}