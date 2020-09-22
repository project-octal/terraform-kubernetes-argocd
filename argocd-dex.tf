module "argocd_dex" {
  source = "./argocd-dex"

  namespace           = var.namespace
  dex_version         = var.dex_version
  dex_image           = var.dex_image
  image_repository    = var.image_repository
  image_pull_policy   = var.image_pull_policy
  dex_run_as_non_root = var.dex_run_as_non_root
  dex_fs_group        = var.dex_fs_group
  dex_run_as_user     = var.dex_run_as_user
  labels              = var.labels
}