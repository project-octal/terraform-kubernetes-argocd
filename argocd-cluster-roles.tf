

resource "kubernetes_cluster_role" "argocd_server" {
  metadata {
    name = "argocd-server"
    labels = merge({
      "app.kubernetes.io/name" : "argocd-server"
      "app.kubernetes.io/component" : "server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
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