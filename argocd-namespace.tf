resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name   = var.namespace
    labels = merge({}, var.labels)
    annotations = var.namespace_annotations
  }
}