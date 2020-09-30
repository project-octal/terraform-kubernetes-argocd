
module "argocd_redis" {
  source = "./argocd-redis"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_tag         = var.argocd_image_tag
  image_name        = var.argocd_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels
}

module "argocd_repo_server" {
  source = "./argocd-repo-server"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_tag         = var.argocd_image_tag
  image_name        = var.argocd_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels

  redis_address = module.argocd_redis.redis_address
  redis_port    = module.argocd_redis.redis_port
}

module "argocd_server" {
  source = "./argocd-server"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  image_tag         = var.argocd_image_tag
  image_name        = var.argocd_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels

  redis_address = module.argocd_redis.redis_address
  redis_port    = module.argocd_redis.redis_port
}
module "argocd_application_controller" {
  source = "./argocd-application-controller"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  argocd_version    = var.argocd_image_tag
  argocd_image      = var.argocd_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels
}
module "argocd_dex" {
  source = "./argocd-dex"

  namespace         = kubernetes_namespace.argocd_namespace.metadata.0.name
  dex_version       = var.dex_version
  dex_image         = var.dex_image
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels
}

