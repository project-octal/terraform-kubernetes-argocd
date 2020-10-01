variable "labels" {
  type = map(string)
}
variable "namespace" {
  type = string
}
variable "checksum-config" {
  type    = string
  default = "790be9eae7c7e468c497c0256949ab96cb3f14b935c6702424647c3c60fba91c"
}
variable "name" {
  type    = string
  default = "argocd-redis-ha-haproxy"
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
  type = string
}
variable "cpu_request" {
  type    = string
  default = "50m"
}
variable "memory_request" {
  type    = string
  default = "64Mi"
}
variable "cpu_limit" {
  type    = string
  default = "100m"
}
variable "memory_limit" {
  type    = string
  default = "128Mi"
}