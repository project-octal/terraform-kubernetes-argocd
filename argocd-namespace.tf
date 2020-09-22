resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name   = var.namespace
    labels = merge({}, var.labels)
  }
}