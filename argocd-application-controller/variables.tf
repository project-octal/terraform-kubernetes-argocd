###########################
## General Configuration ##
###########################
variable "name" {
  type    = string
  default = "argocd-application-controller"
}
variable "namespace" {
  type        = string
  description = "The namespace this ArgoCD deployment will reside in."
}
variable "image_repository" {
  type        = string
  description = "The image repository to use when pulling images."
}
variable "image_pull_policy" {
  type        = string
  description = "Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. | `IfNotPresent`: Only pull the image if it does not already exist on the node. | `Never`: Never pull the image"
}
variable "argocd_version" {
  type        = string
  description = "The version of ArgoCD to deploy."
}
variable "argocd_image" {
  type        = string
  description = "The image to use for the `argocd-application-controller` deployment"
}
variable "labels" {
  type        = map(string)
  description = "Extra Kubernetes labels to include with the resources created by this module"
}
variable "redis_address" {
  type = string
}
variable "redis_port" {
  type = number
}