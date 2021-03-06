module "argocd_redis" {
  source = "./argocd-redis"

  namespace                 = kubernetes_namespace.argocd_namespace.metadata.0.name
  pod_affinity_topology_key = var.pod_affinity_topology_key
  enable_ha_redis           = var.enable_ha_redis
  haproxy_image_name        = var.haproxy_image_name
  haproxy_image_tag         = var.haproxy_image_tag
  redis_image_name          = var.redis_image_name
  redis_image_tag           = var.redis_image_tag
  image_repository          = var.image_repository
  image_pull_policy         = var.image_pull_policy
  labels                    = local.labels
}

module "argocd_repo_server" {
  source = "./argocd-repo-server"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_tag         = var.argocd_image_tag
  image_name        = var.argocd_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels

  replicas      = var.argocd_repo_replicas
  redis_address = module.argocd_redis.redis_address
  redis_port    = module.argocd_redis.redis_port

  cpu_request    = local.argocd_repo_requests_cpu
  memory_request = local.argocd_repo_requests_memory

  cpu_limit    = local.argocd_repo_limits_cpu
  memory_limit = local.argocd_repo_limits_memory

  exec_timeout = var.repo_server_exec_timeout
}

module "argocd_server" {
  source = "./argocd-server"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_tag         = var.argocd_image_tag
  image_name        = var.argocd_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels

  cpu_request    = local.argocd_server_requests_cpu
  memory_request = local.argocd_server_requests_memory

  cpu_limit    = local.argocd_server_limits_cpu
  memory_limit = local.argocd_server_limits_memory

  replicas            = var.argocd_server_replicas
  redis_address       = module.argocd_redis.redis_address
  redis_port          = module.argocd_redis.redis_port
  argocd_url          = var.argocd_url
  cluster_cert_issuer = var.cluster_cert_issuer
  ingress_class       = var.ingress_class
}
module "argocd_application_controller" {
  source = "./argocd-application-controller"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  argocd_version    = var.argocd_image_tag
  argocd_image      = var.argocd_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels
  redis_address     = module.argocd_redis.redis_address
  redis_port        = module.argocd_redis.redis_port
}
module "argocd_dex" {
  source = "./argocd-dex"

  count = var.enable_dex ? 1 : 0

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  dex_version       = var.dex_image_tag
  dex_image         = var.dex_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels
}

