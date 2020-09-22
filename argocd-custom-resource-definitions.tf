resource "k8s_manifest" "applications" {
  content = templatefile("${path.module}/custom-resource-definitions/${var.argocd_version}/applications.argoproj.io.yml", {})
}

resource "k8s_manifest" "app_projects" {
  content = templatefile("${path.module}/custom-resource-definitions/${var.argocd_version}/appprojects.argoproj.io.yml", {})
}