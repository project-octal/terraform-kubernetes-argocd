resource "kubernetes_cluster_role_binding" "argocd_application_controller" {
  metadata {
    name = "argocd-application-controller"
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "argocd-application-controller"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "argocd-application-controller"
    namespace = var.namespace
  }
}

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
    namespace = var.namespace
  }
}