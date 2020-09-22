resource "kubernetes_stateful_set" "argocd_redis_ha" {
  metadata {
    name = "argocd-redis-ha"
    labels = merge({

    }, var.labels)
  }
  spec {
    service_name = ""
    selector {}
    template {
      metadata {}
    }
  }
}
# ---
# apiVersion: apps/v1
# kind: StatefulSet
# metadata:
#   labels:
#     app.kubernetes.io/component: redis
#     app.kubernetes.io/name: argocd-redis-ha
#     app.kubernetes.io/part-of: argocd
#   name: argocd-redis-ha-server
# spec:
#   podManagementPolicy: OrderedReady
#   replicas: 3
#   selector:
#     matchLabels:
#       app.kubernetes.io/name: argocd-redis-ha
#   serviceName: argocd-redis-ha
#   template:
#     metadata:
#       annotations:
#         checksum/init-config: 552ee3bec8fe5d9d865e371f7b615c6d472253649eb65d53ed4ae874f782647c
#       labels:
#         app.kubernetes.io/name: argocd-redis-ha
#     spec:
#       affinity:
#         podAntiAffinity:
#           preferredDuringSchedulingIgnoredDuringExecution:
#           - podAffinityTerm:
#               labelSelector:
#                 matchLabels:
#                   app.kubernetes.io/name: argocd-redis-ha
#               topologyKey: failure-domain.beta.kubernetes.io/zone
#             weight: 100
#           requiredDuringSchedulingIgnoredDuringExecution:
#           - labelSelector:
#               matchLabels:
#                 app.kubernetes.io/name: argocd-redis-ha
#             topologyKey: kubernetes.io/hostname
#       containers:
#       - args:
#         - /data/conf/redis.conf
#         command:
#         - redis-server
#         image: redis:5.0.8-alpine
#         imagePullPolicy: IfNotPresent
#         livenessProbe:
#           initialDelaySeconds: 15
#           tcpSocket:
#             port: 6379
#         name: redis
#         ports:
#         - containerPort: 6379
#           name: redis
#         resources: {}
#         volumeMounts:
#         - mountPath: /data
#           name: data
#       - args:
#         - /data/conf/sentinel.conf
#         command:
#         - redis-sentinel
#         image: redis:5.0.8-alpine
#         imagePullPolicy: IfNotPresent
#         livenessProbe:
#           initialDelaySeconds: 15
#           tcpSocket:
#             port: 26379
#         name: sentinel
#         ports:
#         - containerPort: 26379
#           name: sentinel
#         resources: {}
#         volumeMounts:
#         - mountPath: /data
#           name: data
#       initContainers:
#       - args:
#         - /readonly-config/init.sh
#         command:
#         - sh
#         env:
#         - name: SENTINEL_ID_0
#           value: 25b71bd9d0e4a51945d8422cab53f27027397c12
#         - name: SENTINEL_ID_1
#           value: 896627000a81c7bdad8dbdcffd39728c9c17b309
#         - name: SENTINEL_ID_2
#           value: 3acbca861108bc47379b71b1d87d1c137dce591f
#         image: redis:5.0.8-alpine
#         imagePullPolicy: IfNotPresent
#         name: config-init
#         resources: {}
#         volumeMounts:
#         - mountPath: /readonly-config
#           name: config
#           readOnly: true
#         - mountPath: /data
#           name: data
#       securityContext:
#         fsGroup: 1000
#         runAsNonRoot: true
#         runAsUser: 1000
#       serviceAccountName: argocd-redis-ha
#       volumes:
#       - configMap:
#           name: argocd-redis-ha-configmap
#         name: config
#       - emptyDir: {}
#         name: data
#   updateStrategy:
#     type: RollingUpdate