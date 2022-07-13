resource "kubernetes_service_account" "server_service_account" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
    }, local.labels)
  }

  automount_service_account_token = false
}

resource "kubernetes_secret" "server_service_account" {
  metadata {
    name      = "${var.name}-token-secret"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name"      = var.name
      "kubernetes.io/service-account.namespace" = var.namespace
    }
  }
  type = "kubernetes.io/service-account-token"
}
