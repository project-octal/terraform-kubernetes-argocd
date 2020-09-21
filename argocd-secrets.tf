# ---
# apiVersion: v1
# kind: Secret
# metadata:
#   labels:
#     app.kubernetes.io/name: argocd-secret
#     app.kubernetes.io/part-of: argocd
#   name: argocd-secret
# type: Opaque
resource "kubernetes_secret" "argocd-secret" {
  metadata {
    name = "argocd-secret"
    labels = {
      "app.kubernetes.io/name": "argocd-secret"
      "app.kubernetes.io/part-of": "argocd"
    }
  }
  type = "Opaque"
}