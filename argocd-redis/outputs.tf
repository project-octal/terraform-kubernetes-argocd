
output "redis_address" {
  value = module.argocd_haproxy_ha.0.address
}

output "redis_port" {
  value = module.argocd_haproxy_ha.0.port
}