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
    name      = kubernetes_service_account.argocd_redis_ha.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argocd_redis_ha.metadata.0.name
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
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
    name      = kubernetes_role.argocd_server.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argocd_server.metadata.0.name
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
  }
}