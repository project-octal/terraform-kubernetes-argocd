resource "kubernetes_ingress" "argcd_ingress" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
    annotations = {
      "cert-manager.io/cluster-issuer" : var.cluster_cert_issuer
      "kubernetes.io/ingress.class" : var.ingress_class
      "ingress.kubernetes.io/protocol": "https"
    }
  }
  spec {
    backend {
      service_name = kubernetes_service.argocd_server.metadata.0.name
      service_port = "https" #kubernetes_service.argocd_server.spec.0.port.0.port
    }
    tls {
      hosts = [
        var.argocd_url
      ]
      secret_name = "${kubernetes_deployment.server_deployment.metadata.0.name}.local-tls"
    }
  }
}