variable "labels" {
  type = map(string)
}
variable "namespace" {
  type = string
}
variable "name" {
  type    = string
  default = "argocd-repo-server"
}
variable "component" {
  type    = string
  default = "repo-server"
}
variable "redis_address" {
  type = string
}
variable "redis_port" {
  type = number
}
variable "replicas" {
  type = number
}
variable "image_tag" {
  type = string
}
variable "image_name" {
  type = string
}
variable "image_repository" {
  type = string
}
variable "image_pull_policy" {
  type = string
}
variable "pod_affinity_topology_key" {
  type    = string
  default = "failure-domain.beta.kubernetes.io/zone"
}
variable "cpu_request" {
  type = string
}
variable "memory_request" {
  type = string
}
variable "cpu_limit" {
  type = string
}
variable "memory_limit" {
  type = string
}
variable "exec_timeout" {
  type        = string
  description = ""
  default     = "90s"
}
variable "vault_secret_plugin_enabled" {
  type = bool
}
variable "vault_secret_plugin_artifact_url" {
  type = string
}
variable "vault_secret_plugin_secret_name" {
  type = string
}
variable "vault_secret_plugin_secret_config" {
  type = object({
    vault_addr    = string,
    vault_token   = string,
    avp_auth_type = string,
    avp_type      = string
  })
}