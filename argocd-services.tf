# ---
# apiVersion: v1
# kind: Service
# metadata:
#   annotations:
#     service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
#   labels:
#     app.kubernetes.io/component: redis
#     app.kubernetes.io/name: argocd-redis-ha
#     app.kubernetes.io/part-of: argocd
#   name: argocd-redis-ha-announce-0
# spec:
#   ports:
#   - name: server
#     port: 6379
#     protocol: TCP
#     targetPort: redis
#   - name: sentinel
#     port: 26379
#     protocol: TCP
#     targetPort: sentinel
#   publishNotReadyAddresses: true
#   selector:
#     app.kubernetes.io/name: argocd-redis-ha
#     statefulset.kubernetes.io/pod-name: argocd-redis-ha-server-0
#   type: ClusterIP
resource "kubernetes_service" "argocd_redis_ha_announce_0" {
  metadata {
    name = "argocd-redis-ha"
    labels = {
      "app.kubernetes.io/name": "argocd-redis-ha"
      "app.kubernetes.io/component": "redis"
      "app.kubernetes.io/part-of": "argocd"
    }
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints": "true"
    }
  }
  spec {
    port {
      name = "server"
      protocol = "TCP"
      port = 6379
      target_port = "redis"
    }
    port {
      name = "sentinel"
      protocol = "TCP"
      port = 26379
      target_port = "sentinel"
    }
    publish_not_ready_addresses = true
    selector = {
      "app.kubernetes.io/name": "argocd-redis-ha"
      "statefulset.kubernetes.io/pod-name": "argocd-redis-ha-server-0"
    }
  }
}

# ---
# apiVersion: v1
# kind: Service
# metadata:
#   annotations:
#     service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
#   labels:
#     app.kubernetes.io/component: redis
#     app.kubernetes.io/name: argocd-redis-ha
#     app.kubernetes.io/part-of: argocd
#   name: argocd-redis-ha-announce-1
# spec:
#   ports:
#   - name: server
#     port: 6379
#     protocol: TCP
#     targetPort: redis
#   - name: sentinel
#     port: 26379
#     protocol: TCP
#     targetPort: sentinel
#   publishNotReadyAddresses: true
#   selector:
#     app.kubernetes.io/name: argocd-redis-ha
#     statefulset.kubernetes.io/pod-name: argocd-redis-ha-server-1
#   type: ClusterIP
resource "kubernetes_service" "argocd-redis-ha-announce-1" {
  metadata {
    name = "argocd-redis-ha-announce-1"
    labels = {
      "app.kubernetes.io/name": "argocd-redis-ha"
      "app.kubernetes.io/component": "redis"
      "app.kubernetes.io/part-of": "argocd"
    }
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints": "true"
    }
  }
  spec {
    port {
      name = "server"
      protocol = "TCP"
      port = 6379
      target_port = "redis"
    }
    port {
      name = "sentinel"
      protocol = "TCP"
      port = 26379
      target_port = "sentinel"
    }
  }
  publish_not_ready_addresses = true
  selector = {
    "app.kubernetes.io/name": "argocd-redis-ha"
    "statefulset.kubernetes.io/pod-name": "argocd-redis-ha-server-1"
  }
}

#---
#apiVersion: v1
#kind: Service
#metadata:
#  annotations:
#    service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
#  labels:
#    app.kubernetes.io/component: redis
#    app.kubernetes.io/name: argocd-redis-ha
#    app.kubernetes.io/part-of: argocd
#  name: argocd-redis-ha-announce-2
#spec:
#  ports:
#  - name: server
#    port: 6379
#    protocol: TCP
#    targetPort: redis
#  - name: sentinel
#    port: 26379
#    protocol: TCP
#    targetPort: sentinel
#  publishNotReadyAddresses: true
#  selector:
#    app.kubernetes.io/name: argocd-redis-ha
#    statefulset.kubernetes.io/pod-name: argocd-redis-ha-server-2
#  type: ClusterIP
resource "kubernetes_service" "argocd-redis-ha-announce-2" {
  metadata {
    name = "argocd-redis-ha-announce-2"
    labels = {
      "app.kubernetes.io/name": "argocd-redis-ha"
      "app.kubernetes.io/component": "redis"
      "app.kubernetes.io/part-of": "argocd"
    }
    annotations = {
      "service.alpha.kubernetes.io/tolerate-unready-endpoints": "true"
    }
  }
  spec {
    port {
      name = "server"
      protocol = "TCP"
      port = 6379
      target_port = "redis"
    }
    port {
      name = "sentinel"
      protocol = "TCP"
      port = 26379
      target_port = "sentinel"
    }
  }
  publish_not_ready_addresses = true
  selector = {
    "app.kubernetes.io/name": "argocd-redis-ha"
    "statefulset.kubernetes.io/pod-name": "argocd-redis-ha-server-2"
  }
}

# ---
# apiVersion: v1
# kind: Service
# metadata:
#   annotations: null
#   labels:
#     app.kubernetes.io/component: redis
#     app.kubernetes.io/name: argocd-redis-ha-haproxy
#     app.kubernetes.io/part-of: argocd
#   name: argocd-redis-ha-haproxy
# spec:
#   ports:
#   - name: haproxy
#     port: 6379
#     protocol: TCP
#     targetPort: redis
#   selector:
#     app.kubernetes.io/name: argocd-redis-ha-haproxy
#   type: ClusterIP
resource "kubernetes_service" "argocd_redis_ha_haproxy" {
  metadata {
    name = "argocd-redis-ha-haproxy"
    labels = {
      "app.kubernetes.io/name": "argocd-redis-ha-haproxy"
      "app.kubernetes.io/component": "redis"
      "app.kubernetes.io/part-of": "argocd"
    }
    annotations = null
  }
  spec {
    port {
      name = "haproxy"
      protocol = "TCP"
      port = 6379
      target_port = "redis"
    }
    selector = {
      "app.kubernetes.io/name": "argocd-redis-ha-haproxy"
    }
  }
}