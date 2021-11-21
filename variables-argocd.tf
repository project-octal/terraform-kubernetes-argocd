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
  default     = "v1.7.7"
}
variable "argocd_image_name" {
  type        = string
  description = "The image to use when deploying ArgoCD"
  default     = "argoproj/argocd"
}
variable "argocd_image_repository" {
  type        = string
  description = "The image repository to use when pulling images."
  default     = "quay.io"
}
variable "image_pull_policy" {
  type        = string
  description = "Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. | `IfNotPresent`: Only pull the image if it does not already exist on the node. | `Never`: Never pull the image"
  default     = "Always"
}
variable "cluster_cert_issuer" {
  type        = string
  description = "The cluster certificate issuer to use when creating a TLS certificate for the ingress"
}
variable "ingress_class" {
  type        = string
  description = "The ingress class that the ArgoCD ingress record should reference."
}

variable "enable_ingress" {
  type        = bool
  description = "If set to `true` an ingress route will be created for ArgoCD"
  default     = false
}