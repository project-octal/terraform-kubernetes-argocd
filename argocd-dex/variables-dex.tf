###########################
## General Configuration ##
###########################
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
variable "labels" {
  type        = map(string)
  description = "Extra Kubernetes labels to include with the resources created by this module"
}
variable "argocd_version" {
  type        = string
  description = "The version of ArgoCD to deploy."
  default     = "1.7.6"
}
variable "argocd_server_image" {
  type        = string
  description = "The image to use for the `argocd-server` deployment"
  default     = "argoproj/argocd"
}

#######################
## Dex Configuration ##
#######################
variable "dex_image" {
  type        = string
  description = ""
}
variable "dex_version" {
  type        = string
  description = "The version of the Dex Docker image to deploy."
}