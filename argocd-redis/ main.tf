module "argocd_haproxy_ha" {
  source = "./haproxy-ha"

  count = var.enable_ha_redis ? 1 : 0

  namespace                 = var.namespace
  image_tag                 = var.haproxy_image_tag
  image_name                = var.haproxy_image_name
  image_repository          = var.haproxy_image_repository
  image_pull_policy         = var.image_pull_policy
  labels                    = var.labels
  pod_affinity_topology_key = var.pod_affinity_topology_key
}

module "argocd_redis_ha" {
  source = "./redis-ha"

  count = var.enable_ha_redis ? 1 : 0

  namespace                 = var.namespace
  image_tag                 = var.redis_image_tag
  image_name                = var.redis_image_name
  image_repository          = var.redis_image_repository
  image_pull_policy         = var.image_pull_policy
  labels                    = var.labels
  pod_affinity_topology_key = var.pod_affinity_topology_key
}

module "argocd_redis" {
  source = "./redis"

  count = var.enable_ha_redis ? 0 : 1

  namespace         = var.namespace
  image_tag         = var.redis_image_tag
  image_name        = var.redis_image_name
  image_repository  = var.redis_image_repository
  image_pull_policy = var.image_pull_policy
  labels            = var.labels
}