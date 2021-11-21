module "argocd" {
  source = "../../"

  argocd_url = "argocd.test.app"
  argocd_image_tag  = "v2.0.2"
#  haproxy_image_tag = "2.0.4"
  redis_image_tag   = "6.2.4-alpine"

  namespace              = "kube-argocd"
  argocd_server_replicas = 1
  argocd_repo_replicas   = 1

  enable_dex      = false
  enable_ha_redis = false

  cluster_cert_issuer = null
  ingress_class       = "nginx"

  argocd_server_requests = {
    cpu = "300m"
    memory = "256Mi"
  }
  argocd_server_limits = {
    cpu = "600m"
    memory = "512Mi"
  }

  repo_server_exec_timeout = "300"
  argocd_repo_requests = {
    cpu = "300m"
    memory = "256Mi"
  }
  argocd_repo_limits = {
    cpu = "600m"
    memory = "512Mi"
  }
  argocd_repositories = [
    {
      name = "Helm-Main"
      type = "helm"
      url = "https://charts.helm.sh/stable"
    }
  ]

  oidc_config = null
}