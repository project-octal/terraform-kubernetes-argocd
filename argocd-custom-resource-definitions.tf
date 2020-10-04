resource "k8s_manifest" "applications" {
  content = templatefile("${path.module}/custom-resource-definitions/${var.argocd_image_tag}/applications.argoproj.io.yml", {})
}

resource "k8s_manifest" "app_projects" {
  content = templatefile("${path.module}/custom-resource-definitions/${var.argocd_image_tag}/appprojects.argoproj.io.yml", {})
}
