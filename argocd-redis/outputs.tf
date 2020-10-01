
output "redis_address" {
  value = var.enable_ha_redis ? module.argocd_haproxy_ha.0.address : module.argocd_redis.0.address
}

output "redis_port" {
  value = var.enable_ha_redis ? module.argocd_haproxy_ha.0.port : module.argocd_redis.0.port
}