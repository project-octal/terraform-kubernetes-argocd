resource "kubernetes_ingress" "argocd_ingress_route" {
  count = var.ingress_enabled ? 1 : 0

  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = local.ingress_annotations
    labels      = local.labels
  }

  spec {
    ingress_class_name = var.ingress_class_name
    rule {
      host = var.ingress_host
      http {
        path {
          path = var.ingress_path
          backend {
            service_name = kubernetes_service.argocd_server.metadata.0.name
            service_port = 443
          }
        }
      }
    }
    dynamic "tls" {
      for_each = var.ingress_cert_issuer_annotation != null ? [1] : []
      content {
        hosts       = [var.ingress_host]
        secret_name = "argocd-ingress-tls"
      }
    }
  }
}