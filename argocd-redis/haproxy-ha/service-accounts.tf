resource "kubernetes_service_account" "haproxy_service_account" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }
  automount_service_account_token = false
}