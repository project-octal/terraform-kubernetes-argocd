resource "kubernetes_role_binding" "argocd_redis_ha" {
  metadata {
    name      = "argocd-redis-ha"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "app.kubernetes.io/component" : "redis"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "argocd-redis-ha"
  }
  subject {
    kind = "ServiceAccount"
    name = "argocd-redis-ha"
  }
}





resource "kubernetes_role_binding" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-server"
      "app.kubernetes.io/component" : "server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "argocd-server"
  }
  subject {
    kind = "ServiceAccount"
    name = "argocd-server"
  }
}