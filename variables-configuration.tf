variable "argocd_url" {
  type        = string
  description = "Argo CD's externally facing base URL. Required when configuring SSO"
  default     = null
}
variable "enable_oidc" {
  type        = bool
  description = "Sets whether or not to enable OIDC authentication"
  default     = false
}
variable "enable_status_badge" {
  type        = bool
  description = "Enables application status badge feature"
  default     = false
}
variable "enable_anonymous_access" {
  type        = bool
  description = "Enables anonymous user access. The anonymous users get default role permissions specified argocd-rbac-cm.yaml."
  default     = false
}
variable "help_chat_url" {
  type        = string
  description = "The URL for getting chat help, this will typically be your Slack channel for support"
  default     = null
}
variable "helm_chat_text" {
  type        = string
  description = "The text for getting chat help"
  default     = "Chat now!"
}
variable "oidc_config" {
  type        = object({ name : string, issuer : string, clientID : string, clientSecret : string, requestedScopes : list(string), requestedIDTokenClaims : map(any) })
  description = "OIDC configuration as an alternative to dex"
  default     = null
}
variable "repository_credentials" {
  type        = list(map(any))
  description = "A list of git repositories that ArgoCD will be configured to use."
  default     = []
}
variable "argocd_git_repositories" {
  type        = list(map(any))
  description = "A list of credentials that ArgoCD will use when pulling from configured repositories."
  default     = []
}
variable "argocd_repositories" {
  type        = list(map(any))
  description = "A list of repositories that ArgoCD might pull from."
  default     = []
}
variable "argocd_repository_credentials" {
  type        = list(map(any))
  description = "A list of repositories that ArgoCD might pull from."
  default     = []
}