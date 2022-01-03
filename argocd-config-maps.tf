resource "kubernetes_config_map" "argocd_redis_ha_configmap" {
  metadata {
    name      = "argocd-redis-ha-configmap"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-redis-ha"
      "app.kubernetes.io/component" : "redis"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  data = {
    "haproxy.cfg"     = templatefile("${path.module}/configuration-files/haproxy.cfg", {})
    "haproxy_init.sh" = templatefile("${path.module}/configuration-files/haproxy_init.sh", {})
    "init.sh"         = templatefile("${path.module}/configuration-files/init.sh", {})
    "redis.conf"      = templatefile("${path.module}/configuration-files/redis.conf", {})
    "sentinel.conf"   = templatefile("${path.module}/configuration-files/sentinel.conf", {})
  }
}

resource "kubernetes_config_map" "argocd_cm" {
  metadata {
    name      = "argocd-cm"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-cm"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  data = {
    url                       = "https://${var.ingress_host}${var.ingress_path}"
    "oidc.config"             = var.oidc_config != null ? yamlencode(local.oidc_config) : null
    "repositories"            = yamlencode(var.argocd_repositories),
    "repository.credentials"  = yamlencode(var.argocd_repository_credentials)
    "resource.customizations" = templatefile("${path.module}/configuration-files/resource-customizations.yml", {})
    "configManagementPlugins" = templatefile("${path.module}/configuration-files/plugin-config.yml", {})
    # "configManagementPlugins" = var.vault_secret_plugin_enabled ? yamlencode([{
    #   name = "argocd-vault-plugin"
    #   generate = {
    #     command = ["argocd-vault-plugin"]
    #     args    = ["generate", "./"]
    #   }
    # }]) : null
  }
}

resource "kubernetes_config_map" "argocd_gpg_keys_cm" {
  metadata {
    name      = "argocd-gpg-keys-cm"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-gpg-keys-cm"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
}

resource "kubernetes_config_map" "argocd_rbac_cm" {
  metadata {
    name      = "argocd-rbac-cm"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-rbac-cm"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  data = {
    "policy.csv" = templatefile("${path.module}/configuration-files/policy.csv", {})
    #"policy.default" = "role:readonly"
    # essential to get argo to use groups for RBAC:
    "scopes" = "[https://example.com/claims/groups, email]"
  }
}

resource "kubernetes_config_map" "argocd_ssh_known_hosts_cm" {
  metadata {
    name      = "argocd-ssh-known-hosts-cm"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-ssh-known-hosts-cm"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  data = {
    ssh_known_hosts = templatefile("${path.module}/configuration-files/ssh_known_hosts", {})
  }
}

resource "kubernetes_config_map" "argocd_tls_certs_cm" {
  metadata {
    name      = "argocd-tls-certs-cm"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-tls-certs-cm"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  data = null
}