resource "kubernetes_secret" "vault_secret_plugin_config_secret" {
  count = var.vault_secret_plugin_enabled ? 1 : 0

  type = "Opaque"
  metadata {
    name      = var.vault_secret_plugin_config_secret
    namespace = var.namespace
  }

  data = {
    VAULT_ADDR    = var.vault_secret_plugin_config.vault_addr
    VAULT_TOKEN   = var.vault_secret_plugin_config_secret
    AVP_TYPE      = var.vault_secret_plugin_config.avp_type
    AVP_AUTH_TYPE = var.vault_secret_plugin_config.avp_auth_type
  }
}