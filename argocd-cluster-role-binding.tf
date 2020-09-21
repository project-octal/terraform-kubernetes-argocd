# ---
# apiVersion: rbac.authorization.k8s.io/v1
# kind: ClusterRoleBinding
# metadata:
#   labels:
#     app.kubernetes.io/component: application-controller
#     app.kubernetes.io/name: argocd-application-controller
#     app.kubernetes.io/part-of: argocd
#   name: argocd-application-controller
# roleRef:
#   apiGroup: rbac.authorization.k8s.io
#   kind: ClusterRole
#   name: argocd-application-controller
# subjects:
# - kind: ServiceAccount
#   name: argocd-application-controller
#   namespace: argocd
resource "kubernetes_cluster_role_binding" "argocd_application_controller" {
  metadata {
    name = argocd-application-controller
    labels = merge({
      app.kubernetes.io/component: application-controller
      app.kubernetes.io/name: argocd-application-controller
      app.kubernetes.io/part-of: argocd
    }, var.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "argocd-application-controller"
  }
  subject {
    kind = "ServiceAccount"
    name = "argocd-application-controller"
    namespace = var.namespace
  }
}