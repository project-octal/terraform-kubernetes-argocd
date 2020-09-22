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
}