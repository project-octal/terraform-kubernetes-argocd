resource "kubernetes_role" "argocd_application_controller" {
  metadata {
    name      = "argocd-application-controller"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  rule {
    api_groups = [""]
    resources  = ["secrets", "configmaps"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "list"]
  }
  rule {
    api_groups = ["argoproj.io"]
    resources  = ["applications", "appprojects"]
    verbs      = ["create", "get", "list", "watch", "update", "patch", "delete"]
  }
}