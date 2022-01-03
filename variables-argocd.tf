##########################
## ArgoCD Configuration ##
##########################
variable "namespace" {
  type        = string
  description = "The namespace this ArgoCD deployment will reside in."
  default     = "argocd"
}
variable "labels" {
  type        = map(string)
  description = "Extra Kubernetes labels to include with the resources created by this module"
  default     = {}
}
variable "namespace_annotations" {
  type        = map(string)
  description = "Additional ArgoCD namespace annotations (e.g. for `linkerd.io/inject: enabled` for mesh things)"
  default     = {}
}
variable "argocd_image_tag" {
  type        = string
  description = "The version of ArgoCD to deploy."
  default     = "v2.1.7"
}
variable "argocd_image_name" {
  type        = string
  description = "The image to use when deploying ArgoCD"
  default     = "argoproj/argocd"
}
variable "argocd_image_repository" {
  type        = string
  description = "The image repository to use when pulling images."
  default     = "docker.io"
}
variable "image_pull_policy" {
  type        = string
  description = "Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. | `IfNotPresent`: Only pull the image if it does not already exist on the node. | `Never`: Never pull the image"
  default     = "Always"
}
variable "vault_secret_plugin_enabled" {
  type    = bool
  default = false
}
variable "vault_secret_plugin_config_secret" {
  type        = string
  description = "The name given to the secret containing the Hashicorp vault token"
  default     = "argocd-vault-plugin-credentials"
}
variable "vault_secret_plugin_artifact_url" {
  type        = string
  description = "The URL of the ArgoCD Vault plugin binary"
  default     = "https://github.com/IBM/argocd-vault-plugin/releases/download/v1.6.0/argocd-vault-plugin_1.6.0_linux_amd64"
}
variable "vault_secret_plugin_token" {
  type        = string
  description = "The Hashicorp Vault token ArgoCD will use to authenticate with."
  default     = null
}
variable "vault_secret_plugin_config" {
  type = object({
    vault_addr    = string,
    avp_auth_type = string,
    avp_type      = string
  })
  description = "The plugin configuration. Currently this only propperly support Hashicorp Vault, but in the future could support other vaults."
  default     = null
}