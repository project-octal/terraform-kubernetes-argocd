locals {
  labels = merge({
    "app.kubernetes.io/part-of" : "argocd"
    # Some more labels go here...
  }, var.labels)
}