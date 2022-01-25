module "argocd_redis" {
  source = "./argocd-redis"

  depends_on = [
    kubernetes_manifest.applications, 
    kubernetes_manifest.app_projects
  ]

  namespace                 = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_pull_policy         = var.image_pull_policy
  labels                    = local.labels
  pod_affinity_topology_key = var.pod_affinity_topology_key

  enable_ha_redis          = var.enable_ha_redis
  haproxy_image_name       = var.haproxy_image_name
  haproxy_image_tag        = var.haproxy_image_tag
  haproxy_image_repository = var.haproxy_image_repository
  redis_image_name         = var.redis_image_name
  redis_image_tag          = var.redis_image_tag
  redis_image_repository   = var.redis_image_repository
}

module "argocd_repo_server" {
  source = "./argocd-repo-server"

  depends_on = [
    kubernetes_manifest.applications, 
    kubernetes_manifest.app_projects
  ]

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_pull_policy = var.image_pull_policy
  labels            = local.labels

  image_tag        = var.argocd_image_tag
  image_name       = var.argocd_image_name
  image_repository = var.argocd_image_repository

  replicas      = var.argocd_repo_replicas
  redis_address = module.argocd_redis.redis_address
  redis_port    = module.argocd_redis.redis_port

  cpu_request    = local.argocd_repo_requests_cpu
  memory_request = local.argocd_repo_requests_memory

  cpu_limit    = local.argocd_repo_limits_cpu
  memory_limit = local.argocd_repo_limits_memory

  exec_timeout = var.repo_server_exec_timeout

  argocd_plugins = var.argocd_plugins
}

module "argocd_server" {
  source = "./argocd-server"

  depends_on = [
    kubernetes_manifest.applications, 
    kubernetes_manifest.app_projects
  ]

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_pull_policy = var.image_pull_policy
  labels            = local.labels

  image_tag        = var.argocd_image_tag
  image_name       = var.argocd_image_name
  image_repository = var.argocd_image_repository

  cpu_request    = local.argocd_server_requests_cpu
  memory_request = local.argocd_server_requests_memory

  cpu_limit    = local.argocd_server_limits_cpu
  memory_limit = local.argocd_server_limits_memory

  replicas      = var.argocd_server_replicas
  redis_address = module.argocd_redis.redis_address
  redis_port    = module.argocd_redis.redis_port

  ingress_enabled                = var.ingress_enabled
  ingress_host                   = var.ingress_host
  ingress_path                   = var.ingress_path
  ingress_class_name             = var.ingress_class_name
  ingress_annotations            = var.ingress_annotations
  ingress_cert_issuer_annotation = var.ingress_cert_issuer_annotation
}
module "argocd_application_controller" {
  source = "./argocd-application-controller"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_pull_policy = var.image_pull_policy
  labels            = local.labels

  argocd_version   = var.argocd_image_tag
  argocd_image     = var.argocd_image_name
  image_repository = var.argocd_image_repository
  redis_address    = module.argocd_redis.redis_address
  redis_port       = module.argocd_redis.redis_port
}
module "argocd_dex" {
  source = "./argocd-dex"

  count = var.enable_dex ? 1 : 0

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_pull_policy = var.image_pull_policy
  labels            = local.labels

  argocd_image_tag        = var.argocd_image_tag
  argocd_image_name       = var.argocd_image_name
  argocd_image_repository = var.argocd_image_repository
  dex_image_tag           = var.dex_image_tag
  dex_image_name          = var.dex_image_name
  dex_image_repository    = var.dex_image_repository
}

