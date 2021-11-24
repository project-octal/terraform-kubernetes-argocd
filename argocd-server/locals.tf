locals {
  labels = merge({
    "app.kubernetes.io/component" : var.component
    # Some more labels go here...
  }, var.labels)

  ingress_annotations = merge(
    var.ingress_annotations,
    var.ingress_cert_issuer_annotation != null ? var.ingress_cert_issuer_annotation : {}
  )

}