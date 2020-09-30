resource "kubernetes_service" "argocd_redis_ha_announce_0" {
  metadata {
    name      = "argocd-redis-ha-announce-0"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints" : "true"
    }
  }
  spec {
    type = "ClusterIP"
    port {
      name        = "server"
      protocol    = "TCP"
      port        = 6379
      target_port = "redis"
    }
    port {
      name        = "sentinel"
      protocol    = "TCP"
      port        = 26379
      target_port = "sentinel"
    }
    publish_not_ready_addresses = true
    selector = {
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "statefulset.kubernetes.io/pod-name" : "argocd-redis-ha-server-0"
    }
  }
}

resource "kubernetes_service" "argocd_redis_ha_announce-1" {
  metadata {
    name      = "argocd-redis-ha-announce-1"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints" : "true"
    }
  }
  spec {
    type = "ClusterIP"
    port {
      name        = "server"
      protocol    = "TCP"
      port        = 6379
      target_port = "redis"
    }
    port {
      name        = "sentinel"
      protocol    = "TCP"
      port        = 26379
      target_port = "sentinel"
    }
    publish_not_ready_addresses = true
    selector = {
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "statefulset.kubernetes.io/pod-name" : "argocd-redis-ha-server-1"
    }
  }
}

resource "kubernetes_service" "argocd_redis_ha_announce-2" {
  metadata {
    name      = "argocd-redis-ha-announce-2"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints" : "true"
    }
  }
  spec {
    type = "ClusterIP"
    port {
      name        = "server"
      protocol    = "TCP"
      port        = 6379
      target_port = "redis"
    }
    port {
      name        = "sentinel"
      protocol    = "TCP"
      port        = 26379
      target_port = "sentinel"
    }
    publish_not_ready_addresses = true
    selector = {
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "statefulset.kubernetes.io/pod-name" : "argocd-redis-ha-server-2"
    }
  }
}



resource "kubernetes_service" "argocd_redis_ha" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
    annotations = null
  }
  spec {
    cluster_ip = "None"
    port {
      name        = "server"
      protocol    = "TCP"
      port        = 6379
      target_port = "redis"
    }
    port {
      name        = "sentinel"
      protocol    = "TCP"
      port        = 26379
      target_port = "6379"
    }
    selector = {
      "app.kubernetes.io/name" : var.name
    }
  }
}