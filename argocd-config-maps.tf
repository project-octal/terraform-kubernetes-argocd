# ---
# apiVersion: v1
# data:





# kind: ConfigMap
# metadata:
#   labels:
#     app.kubernetes.io/component: redis
#     app.kubernetes.io/name: argocd-redis-ha
#     app.kubernetes.io/part-of: argocd
#   name: argocd-redis-ha-configmap
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