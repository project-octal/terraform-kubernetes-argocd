locals {
  labels = merge({
    "app.kubernetes.io/component" : var.component
  }, var.labels)
}