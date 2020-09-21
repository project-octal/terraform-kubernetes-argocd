resource "kubernetes_config_map" "argocd_redis_ha_configmap" {
  metadata {
    name = "argocd-redis-ha-configmap"
    labels = {
      "app.kubernetes.io/name": "argocd-redis-ha"
      "app.kubernetes.io/component": "redis"
      "app.kubernetes.io/part-of": "argocd"
    }
  }
  data = {
    haproxy.cfg = templatefile(file("${path.module}/configuration-files/haproxy.cfg"), {})
    haproxy_init.sh = templatefile(file("${path.module}/configuration-files/haproxy_init.sh"), {})
    init.sh = templatefile(file("${path.module}/configuration-files/init.sh"), {})
    redis.conf = templatefile(file("${path.module}/configuration-files/redis.conf"), {})
    sentinel.conf = templatefile(file("${path.module}/configuration-files/sentinel.conf"), {})
  }
}

# ---
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   labels:
#     app.kubernetes.io/name: argocd-cm
#     app.kubernetes.io/part-of: argocd
#   name: argocd-cm
resource "kubernetes_config_map" "argocd_cm" {
  metadata {
    name = "argocd-cm"
    labels = {
      "app.kubernetes.io/name": "argocd-cm"
      "app.kubernetes.io/part-of": "argocd"
    }
  }
}

# ---
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   labels:
#     app.kubernetes.io/name: argocd-gpg-keys-cm
#     app.kubernetes.io/part-of: argocd
#   name: argocd-gpg-keys-cm
resource "kubernetes_config_map" "argocd_gpg_keys_cm" {
  metadata {
    name = "argocd-gpg-keys-cm"
    labels = {
      "app.kubernetes.io/name": "argocd-gpg-keys-cm"
      "app.kubernetes.io/part-of": "argocd"
    }
  }
}

# ---
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   labels:
#     app.kubernetes.io/name: argocd-rbac-cm
#     app.kubernetes.io/part-of: argocd
#   name: argocd-rbac-cm
resource "kubernetes_config_map" "argocd-rbac-cm" {
  metadata {
    name = "argocd-rbac-cm"
    labels = {
      "app.kubernetes.io/name": "argocd-rbac-cm"
      "app.kubernetes.io/part-of": "argocd"
    }
  }
}

# ---
# apiVersion: v1
# data:
# kind: ConfigMap
# metadata:
#   labels:
#     app.kubernetes.io/name: argocd-ssh-known-hosts-cm
#     app.kubernetes.io/part-of: argocd
#   name: argocd-ssh-known-hosts-cm
resource "kubernetes_config_map" "argocd-ssh-known-hosts-cm" {
  metadata {
    name = "argocd-ssh-known-hosts-cm"
    labels = {
      "app.kubernetes.io/name": "argocd-ssh-known-hosts-cm"
      "app.kubernetes.io/part-of": "argocd"
    }
  }
  data = {
    ssh_known_hosts = templatefile(file("${path.module}/configuration-files/ssh_known_hosts"), {})
  }
}

# ---
# apiVersion: v1
# data: null
# kind: ConfigMap
# metadata:
#   labels:
#     app.kubernetes.io/name: argocd-tls-certs-cm
#     app.kubernetes.io/part-of: argocd
#   name: argocd-tls-certs-cm
resource "kubernetes_config_map" "argocd-tls-certs-cm" {
  metadata {
    name = "argocd-tls-certs-cm"
    labels = {
      "app.kubernetes.io/name": "argocd-tls-certs-cm"
      "app.kubernetes.io/part-of": "argocd"
    }
  }
  data = null
}