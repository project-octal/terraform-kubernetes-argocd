variable "labels" {
  type = map(string)
}
variable "namespace" {
  type = string
}
variable "name" {
  type    = string
  default = "argocd-redis"
}
variable "component" {
  type    = string
  default = "redis"
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