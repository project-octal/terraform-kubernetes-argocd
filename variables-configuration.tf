
variable "argocd_repo_replicas" {
  type    = number
  default = 2
}
variable "argocd_server_replicas" {
  type    = number
  default = 2
}

variable "argocd_url" {
  type        = string
  description = "Argo CD's externally facing base URL. Required when configuring SSO"
  default     = "https://127.0.0.1:8080"
}
variable "oidc_config" {
  type = object({
    name : string,
    issuer : string,
    client_id : string,
    client_secret : string,
    requested_scopes : list(string),
    requested_id_token_claims : map(any)
  })
  description = "OIDC authorization provider settings. For more information please refer to: https://argoproj.github.io/argo-cd/operator-manual/user-management/#existing-oidc-provider"
  default     = null
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
variable "pod_affinity_topology_key" {
  type    = string
  default = "failure-domain.beta.kubernetes.io/zone"
}
variable "repo_server_exec_timeout" {
  type        = string
  description = ""
  default     = "90s"
}