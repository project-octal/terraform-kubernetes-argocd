variable "labels" {
  type = map(string)
}
variable "namespace" {
  type = string
}
variable "name" {
  type    = string
  default = "argocd-server"
}
variable "component" {
  type    = string
  default = "server"
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
variable "argocd_url" {
  type = string
}
variable "ingress_class" {
  type        = string
  description = "The ingress class that the ArgoCD ingress record should reference."
}
variable "cluster_cert_issuer" {
  type        = string
  description = "The cluster certificate issuer to use when creating a TLS certificate for the ingress"
}

variable "enable_ingress" {
  type = bool
  default = false
}