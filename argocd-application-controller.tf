module "argocd_application_controller" {
  source = "./argocd-application-controller"

  namespace         = var.namespace
  argocd_version    = var.argocd_version
  argocd_image      = var.argocd_server_image
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = var.labels
}