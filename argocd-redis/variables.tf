variable "labels" {
  type = map(string)
}
variable "namespace" {
  type = string
}
variable "name" {
  type    = string
  default = "argocd-redis-ha"
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