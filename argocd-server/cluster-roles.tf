resource "kubernetes_cluster_role" "argocd_server" {
  metadata {
    name = var.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["get", "patch", "delete"]
  }
  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["list"]
  }
  rule {
    api_groups = [""]
    resources  = ["pod", "pods/log"]
    verbs      = ["get"]
  }
}