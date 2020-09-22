resource "kubernetes_role_binding" "dex_server" {
  metadata {
    name      = "argocd-dex-server"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-dex-server"
      "app.kubernetes.io/component" : "dex-server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "argocd-dex-server"
  }
  subject {
    kind = "ServiceAccount"
    name = "argocd-dex-server"
  }
}