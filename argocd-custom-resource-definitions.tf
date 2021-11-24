resource "kubernetes_manifest" "applications" {
  manifest = yamldecode(templatefile("${path.module}/custom-resource-definitions/${var.argocd_image_tag}/applications.argoproj.io.yml", {}))
}

resource "kubernetes_manifest" "app_projects" {
  manifest = yamldecode(templatefile("${path.module}/custom-resource-definitions/${var.argocd_image_tag}/appprojects.argoproj.io.yml", {}))
}