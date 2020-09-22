resource "kubernetes_service" "argocd_redis_ha_announce_0" {
  metadata {
    name      = "argocd-redis-ha"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "app.kubernetes.io/component" : "redis"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints" : "true"
    }
  }
  spec {
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
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "app.kubernetes.io/component" : "redis"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints" : "true"
    }
  }
  spec {
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
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "app.kubernetes.io/component" : "redis"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints" : "true"
    }
  }
  spec {
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

resource "kubernetes_service" "argocd_redis_ha_haproxy" {
  metadata {
    name      = "argocd-redis-ha-haproxy"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-redis-ha-haproxy"
      "app.kubernetes.io/component" : "redis"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
    annotations = null
  }
  spec {
    port {
      name        = "haproxy"
      protocol    = "TCP"
      port        = 6379
      target_port = "redis"
    }
    selector = {
      "app.kubernetes.io/name" : "argocd-redis-ha-haproxy"
    }
  }
}

resource "kubernetes_service" "argocd_redis_ha" {
  metadata {
    name      = "argocd-redis-ha"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "app.kubernetes.io/component" : "redis"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
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
      "app.kubernetes.io/name" : "argocd-redis-ha"
    }
  }
}

resource "kubernetes_service" "argocd_dex_server" {
  metadata {
    name      = "argocd-dex-server"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-dex-server"
      "app.kubernetes.io/component" : "dex-server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 5556
      target_port = 5556
    }
    port {
      name        = "grpc"
      protocol    = "TCP"
      port        = 5557
      target_port = 5557
    }
    port {
      name        = "metrics"
      protocol    = "TCP"
      port        = 5558
      target_port = 5558
    }
    selector = {
      "app.kubernetes.io/name" : "argocd-dex-server"
    }
  }
}

resource "kubernetes_service" "argocd_metrics" {
  metadata {
    name      = "argocd-metrics"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-metrics"
      "app.kubernetes.io/component" : "metrics"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    port {
      name        = "metrics"
      protocol    = "TCP"
      port        = 8082
      target_port = 8082
    }
    selector = {
      "app.kubernetes.io/name" : "argocd-application-controller"
    }
  }
}

resource "kubernetes_service" "argocd_repo_server" {
  metadata {
    name      = "argocd-repo-server"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-repo-server"
      "app.kubernetes.io/component" : "repo-server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    port {
      name        = "server"
      protocol    = "TCP"
      port        = 8081
      target_port = 8081
    }
    port {
      name        = "metrics"
      protocol    = "TCP"
      port        = 8084
      target_port = 8084
    }
    selector = {
      "app.kubernetes.io/name" : "argocd-repo-server"
    }
  }
}

resource "kubernetes_service" "argocd_server_metrics" {
  metadata {
    name      = "argocd-server-metrics"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-server-metrics"
      "app.kubernetes.io/component" : "server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    port {
      name        = "metrics"
      protocol    = "TCP"
      port        = 8083
      target_port = 8083
    }
    selector = {
      "app.kubernetes.io/name" : "argocd-server"
    }
  }
}

resource "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-server"
      "app.kubernetes.io/component" : "server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 80
      target_port = "8080"
    }
    port {
      name        = "https"
      protocol    = "TCP"
      port        = 443
      target_port = 8080
    }
    selector = {
      "app.kubernetes.io/name" : "argocd-server"
    }
  }
}