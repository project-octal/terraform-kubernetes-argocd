resource "kubernetes_role" "argocd_redis_ha" {
  metadata {
    name = "argocd-redis-ha"
    labels = merge({
      "app.kubernetes.io/name": "argocd-redis-ha"
      "app.kubernetes.io/component": "redis"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
  rule {
    api_groups = [""]
    resources = ["endpoints"]
    verbs = ["get"]
  }
}

resource "kubernetes_role" "argocd_application_controller" {
  metadata {
    name = "argocd-application-controller"
    labels = merge({
      "app.kubernetes.io/name": "argocd-application-controller"
      "app.kubernetes.io/component": "application-controller"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
  rule {
    api_groups = [""]
    resources = ["secrets", "configmaps"]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources = ["events"]
    verbs = ["create", "list"]
  }
  rule {
    api_groups = ["argoproj.io"]
    resources = ["applications", "appprojects"]
    verbs = ["create", "get", "list", "watch", "update", "patch", "delete"]
  }
}

resource "kubernetes_role" "argocd_dex_server" {
  metadata {
    name = "argocd-dex-server"
    labels = merge({
      "app.kubernetes.io/name": "argocd-dex-server"
      "app.kubernetes.io/component": "dex-server"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
  rule {
    api_groups = [""]
    resources = ["secrets", "configmaps"]
    verbs = ["get", "list", "watch"]
  }
}

resource "kubernetes_role" "argocd_server" {
  metadata {
    name = "argocd-server"
    labels = merge({
      "app.kubernetes.io/name": "argocd-server"
      "app.kubernetes.io/component": "server"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
  rule {
    api_groups = [""]
    resources = ["secrets", "configmaps"]
    verbs = ["create", "get", "list", "watch", "update", "patch", "delete"]
  }
  rule {
    api_groups = [""]
    resources = ["events"]
    verbs = ["create", "list"]
  }
  rule {
    api_groups = ["argoproj.io"]
    resources = ["applications", "appprojects"]
    verbs = ["create", "get", "list", "watch", "update", "patch", "delete"]
  }
}