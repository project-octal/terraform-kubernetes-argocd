resource "kubernetes_service" "argocd_metrics" {
  metadata {
    name      = "argocd-metrics"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-metrics"
      "app.kubernetes.io/component" : "metrics"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    port {
      name        = "metrics"
      protocol    = "TCP"
      port        = 8082
      target_port = 8082
    }
    selector = {
      "app.kubernetes.io/name" : "argocd-application-controller"
    }
  }
}