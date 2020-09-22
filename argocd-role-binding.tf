resource "kubernetes_role_binding" "argocd_redis_ha" {
  metadata {
    name = argocd-redis-ha
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

resource "kubernetes_role_binding" "argocd_application_controller" {
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
    kind      = "Role"
    name      = "argocd-application-controller"
  }
  subject {
    kind = "ServiceAccount"
    name = "argocd-application-controller"
  }
}

resource "kubernetes_role_binding" "argocd_dex_server" {
  metadata {
    name = argocd-dex-server
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

resource "kubernetes_role_binding" "argocd_server" {
  metadata {
    name = argocd-server
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