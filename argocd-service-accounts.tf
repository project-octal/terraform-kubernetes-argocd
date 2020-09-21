resource "kubernetes_service_account" "argocd_redis_ha_haproxy" {
  metadata {
    name = "argocd-redis-ha-haproxy"
    labels = merge({
      "app.kubernetes.io/name": "argocd-redis-ha-haproxy"
      "app.kubernetes.io/component": "redis"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
}

resource "kubernetes_service_account" "argocd_redis_ha" {
  metadata {
    name = "argocd-redis-ha"
    labels = merge({
      "app.kubernetes.io/name": "argocd-redis-ha"
      "app.kubernetes.io/component": "redis"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
}

resource "kubernetes_service_account" "argocd_application_controller" {
  metadata {
    name = "argocd-application-controller"
    labels = merge({
      "app.kubernetes.io/name": "argocd-application-controller"
      "app.kubernetes.io/component": "application-controller"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
}

resource "kubernetes_service_account" "argocd_dex_server" {
  metadata {
    name = "argocd-dex-server"
    labels = merge({
      "app.kubernetes.io/name": "argocd-dex-server"
      "app.kubernetes.io/component": "dex-server"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
}

resource "kubernetes_service_account" "argocd_server" {
  metadata {
    name = "argocd-server"
    labels = merge({
      "app.kubernetes.io/name": "argocd-server"
      "app.kubernetes.io/component": "server"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
}