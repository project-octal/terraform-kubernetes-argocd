output "namespace" {
  depends_on = [
    module.argocd_server,
    module.argocd_repo_server,
    module.argocd_application_controller
  ]
  value = kubernetes_namespace.argocd_namespace.metadata.0.name
}