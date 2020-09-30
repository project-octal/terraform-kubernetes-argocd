resource "kubernetes_cluster_role_binding" "server_cluster_role_binding" {
  metadata {
    name = var.name
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.name
    namespace = var.namespace
  }
}