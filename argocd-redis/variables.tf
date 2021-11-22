variable "labels" {
  type = map(string)
}
variable "namespace" {
  type = string
}
variable "enable_ha_redis" {
  type = bool
}
variable "haproxy_image_tag" {
  type = string
}
variable "haproxy_image_name" {
  type = string
}
variable "haproxy_image_repository" {
  type = string
}
variable "redis_image_tag" {
  type = string
}
variable "redis_image_name" {
  type = string
}
variable "redis_image_repository" {
  type = string
}
variable "image_pull_policy" {
  type = string
}
variable "pod_affinity_topology_key" {
  type = string
}