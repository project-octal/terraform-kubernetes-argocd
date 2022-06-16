##########################
## ArgoCD Configuration ##
##########################
variable "namespace" {
  type        = string
  description = "The namespace this ArgoCD deployment will reside in."
  default     = "argocd"
}
variable "labels" {
  type        = map(string)
  description = "Extra Kubernetes labels to include with the resources created by this module"
  default     = {}
}
variable "namespace_annotations" {
  type        = map(string)
  description = "Additional ArgoCD namespace annotations (e.g. for `linkerd.io/inject: enabled` for mesh things)"
  default     = {}
}
variable "argocd_image_tag" {
  type        = string
  description = "The version of ArgoCD to deploy."
  default     = "v2.4.0"
}
variable "argocd_image_name" {
  type        = string
  description = "The image to use when deploying ArgoCD"
  default     = "argoproj/argocd"
}
variable "argocd_image_repository" {
  type        = string
  description = "The image repository to use when pulling images."
  default     = "docker.io"
}
variable "image_pull_policy" {
  type        = string
  description = "Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. | `IfNotPresent`: Only pull the image if it does not already exist on the node. | `Never`: Never pull the image"
  default     = "Always"
}