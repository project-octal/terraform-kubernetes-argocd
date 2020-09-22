resource "kubernetes_secret" "argocd_secret" {
  metadata {
    name = "argocd-secret"
    labels = merge({
      "app.kubernetes.io/name" : "argocd-secret"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  type = "Opaque"
}