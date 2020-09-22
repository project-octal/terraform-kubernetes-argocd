resource "kubernetes_service" "dex_server" {
  metadata {
    name      = "argocd-dex-server"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-dex-server"
      "app.kubernetes.io/component" : "dex-server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 5556
      target_port = 5556
    }
    port {
      name        = "grpc"
      protocol    = "TCP"
      port        = 5557
      target_port = 5557
    }
    port {
      name        = "metrics"
      protocol    = "TCP"
      port        = 5558
      target_port = 5558
    }
    selector = {
      "app.kubernetes.io/name" : "argocd-dex-server"
    }
  }
}