variable "labels" {
  type = map(string)
}
variable "namespace" {
  type = string
}
variable "checksum-init-config" {
  type    = string
  default = "552ee3bec8fe5d9d865e371f7b615c6d472253649eb65d53ed4ae874f782647c"
}
variable "name" {
  type    = string
  default = "argocd-redis-ha"
}
variable "component" {
  type    = string
  default = "redis"
}
variable "replicas" {
  type    = number
  default = 3
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