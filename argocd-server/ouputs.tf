output "argocd_server_service" {
  value = kubernetes_service.argocd_server.metadata.0.name
}
output "argocd_metrics_server_service" {
  value = kubernetes_service.argocd_server_metrics.metadata.0.name
}