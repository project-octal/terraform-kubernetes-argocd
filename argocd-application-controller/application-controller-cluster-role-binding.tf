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
    name      = kubernetes_cluster_role.argocd_application_controller.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argocd_application_controller.metadata.0.name
    namespace = var.namespace
  }
}