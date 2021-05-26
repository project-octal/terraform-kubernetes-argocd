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
  type    = string
  default = "25m"
}
variable "memory_request" {
  type    = string
  default = "32Mi"
}
variable "cpu_limit" {
  type    = string
  default = "50m"
}
variable "memory_limit" {
  type    = string
  default = "64Mi"
}
variable "exec_timeout" {
  type = string
  description = ""
  default = "90s"
}