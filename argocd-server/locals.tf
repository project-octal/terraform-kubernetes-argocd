locals {
  labels = merge({
    "app.kubernetes.io/component" : var.component
    # Some more labels go here...
  }, var.labels)
}