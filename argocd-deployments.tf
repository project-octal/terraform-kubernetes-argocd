
# ---
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   labels:
#     app.kubernetes.io/component: redis
#     app.kubernetes.io/name: argocd-redis-ha-haproxy
#     app.kubernetes.io/part-of: argocd
#   name: argocd-redis-ha-haproxy
# spec:
#   replicas: 3
#   revisionHistoryLimit: 1
#   selector:
#     matchLabels:
#       app.kubernetes.io/name: argocd-redis-ha-haproxy
#   strategy:
#     type: RollingUpdate
#   template:
#     metadata:
#       annotations:
#         checksum/config: 790be9eae7c7e468c497c0256949ab96cb3f14b935c6702424647c3c60fba91c
#       labels:
#         app.kubernetes.io/name: argocd-redis-ha-haproxy
#       name: argocd-redis-ha-haproxy
#     spec:
#       affinity:
#         podAntiAffinity:
#           preferredDuringSchedulingIgnoredDuringExecution:
#           - podAffinityTerm:
#               labelSelector:
#                 matchLabels:
#                   app.kubernetes.io/name: argocd-redis-ha-haproxy
#               topologyKey: failure-domain.beta.kubernetes.io/zone
#             weight: 100
#           requiredDuringSchedulingIgnoredDuringExecution:
#           - labelSelector:
#               matchLabels:
#                 app.kubernetes.io/name: argocd-redis-ha-haproxy
#             topologyKey: kubernetes.io/hostname
#       containers:
#       - image: haproxy:2.0.4
#         imagePullPolicy: IfNotPresent
#         livenessProbe:
#           httpGet:
#             path: /healthz
#             port: 8888
#           initialDelaySeconds: 5
#           periodSeconds: 3
#         name: haproxy
#         ports:
#         - containerPort: 6379
#           name: redis
#         resources: {}
#         volumeMounts:
#         - mountPath: /usr/local/etc/haproxy
#           name: data
#         - mountPath: /run/haproxy
#           name: shared-socket
#       initContainers:
#       - args:
#         - /readonly/haproxy_init.sh
#         command:
#         - sh
#         image: haproxy:2.0.4
#         imagePullPolicy: IfNotPresent
#         name: config-init
#         resources: {}
#         volumeMounts:
#         - mountPath: /readonly
#           name: config-volume
#           readOnly: true
#         - mountPath: /data
#           name: data
#       nodeSelector: {}
#       securityContext:
#         fsGroup: 1000
#         runAsNonRoot: true
#         runAsUser: 1000
#       serviceAccountName: argocd-redis-ha-haproxy
#       tolerations: null
#       volumes:
#       - configMap:
#           name: argocd-redis-ha-configmap
#         name: config-volume
#       - emptyDir: {}
#         name: shared-socket
#       - emptyDir: {}
#         name: data