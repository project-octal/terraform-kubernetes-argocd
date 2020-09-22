resource "kubernetes_service_account" "dex_server" {
  metadata {
    name      = "argocd-dex-server"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-dex-server"
      "app.kubernetes.io/component" : "dex-server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
}