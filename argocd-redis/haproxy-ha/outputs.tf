output "address" {
  value = kubernetes_service.haproxy_service.metadata.0.name
}
output "port" {
  value = kubernetes_service.haproxy_service.spec.port.0.port
}