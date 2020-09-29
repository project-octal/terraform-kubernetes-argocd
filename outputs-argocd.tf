output "namespace" {
  value = kubernetes_namespace.argocd_namespace.metadata.0.name
}