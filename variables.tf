###########################
## ArgoCD Configurations ##
###########################
variable "argocd_version" {
  type        = string
  description = "The version of ArgoCD to deploy."
  default     = "1.7.6"
}

variable "namespace" {
  type        = string
  description = "The namespace this ArgoCD deployment will reside in."
  default     = "argocd"
}

variable "image_repository" {
  type = string
  description = "The image repository to use when pulling images."
  default = "registry.hub.docker.com/library"
}
variable "image_pull_policy" {
  type = string
  description = "Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. | `IfNotPresent`: Only pull the image if it does not already exist on the node. | `Never`: Never pull the image"
  default = "Always"
}
variable "labels" {
  type        = map(string)
  description = "Extra Kubernetes labels to include with the resources created by this module"
  default     = {}
}



variable "haproxy_version" {
  type = string
  description = "Defines which docker image tag to use for HAProxy"
  default = "2.0.4"
}

variable "fs_group" {
  type = number
  description = ""
  default = 1000
}
variable "run_as_non_root" {
  type = bool
  description = ""
  default = true
}
variable "run_as_user" {
  type = number
  description = ""
  default = 1000
}