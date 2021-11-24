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
variable "ingress_host" {
  type = string
}
variable "ingress_path" {
  type = string
}
variable "ingress_enabled" {
  type = bool
}
variable "ingress_class_name" {
  type = string
}
variable "ingress_annotations" {
  type = map(string)
}
variable "ingress_cert_issuer_annotation" {
  type = map(string)
}