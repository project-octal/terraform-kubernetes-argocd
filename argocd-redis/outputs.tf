
output "redis_address" {
  value = module.argocd_haproxy_ha.address
}

output "redis_port" {
  value = module.argocd_haproxy_ha.port
}