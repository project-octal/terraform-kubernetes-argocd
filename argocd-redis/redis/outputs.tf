output "address" {
  value = kubernetes_service.argocd_redis.metadata.0.name
}
output "port" {
  value = kubernetes_service.argocd_redis.spec.0.port.0.port
}