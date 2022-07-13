resource "kubernetes_service_account" "argocd_application_controller" {
  metadata {
    name      = "argocd-application-controller"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  automount_service_account_token = false
}

resource "kubernetes_secret" "argocd_application_controller" {
  metadata {
    name      = "${var.name}-token-secret"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name"      = var.name
      "kubernetes.io/service-account.namespace" = var.namespace
    }
  }
  type = "kubernetes.io/service-account-token"
}