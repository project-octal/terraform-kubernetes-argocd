resource "kubernetes_cluster_role_binding" "argocd_server" {
  metadata {
    name = "argocd-server"
    labels = merge({
      "app.kubernetes.io/name" : "argocd-server"
      "app.kubernetes.io/component" : "server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "argocd-server"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "argocd-server"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
  }
}