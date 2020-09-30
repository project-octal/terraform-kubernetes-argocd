resource "kubernetes_role" "argocd_server" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  rule {
    api_groups = [""]
    resources  = ["secrets", "configmaps"]
    verbs      = ["create", "get", "list", "watch", "update", "patch", "delete"]
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