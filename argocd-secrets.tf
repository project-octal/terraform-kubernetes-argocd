resource "kubernetes_secret" "argocd_secret" {
  metadata {
    name      = "argocd-secret"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-secret"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  type = "Opaque"
}