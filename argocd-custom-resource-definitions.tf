resource "kubernetes_manifest" "applications" {
  field_manager {
    force_conflicts = true
  }
  manifest = yamldecode(templatefile("${path.module}/custom-resource-definitions/${var.argocd_image_tag}/applications.argoproj.io.yml", {}))
}

resource "kubernetes_manifest" "app_projects" {
  field_manager {
    force_conflicts = true
  }
  manifest = yamldecode(templatefile("${path.module}/custom-resource-definitions/${var.argocd_image_tag}/appprojects.argoproj.io.yml", {}))
}