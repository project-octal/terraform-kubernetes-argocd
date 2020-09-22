###########################
## ArgoCD Configurations ##
###########################
variable "namespace" {
  type        = string
  description = "The namespace this ArgoCD deployment will reside in."
  default     = "argocd"
}

variable "image_repository" {
  type        = string
  description = "The image repository to use when pulling images."
  default     = "registry.hub.docker.com"
}
variable "image_pull_policy" {
  type        = string
  description = "Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. | `IfNotPresent`: Only pull the image if it does not already exist on the node. | `Never`: Never pull the image"
  default     = "Always"
}
variable "labels" {
  type        = map(string)
  description = "Extra Kubernetes labels to include with the resources created by this module"
  default     = {}
}

############################
## HAProxy Configurations ##
############################
variable "haproxy_image" {
  type        = string
  description = ""
  default     = "haproxy"
}
variable "haproxy_version" {
  type        = string
  description = "Defines which docker image tag to use for HAProxy"
  default     = "2.0.4"
}
variable "haproxy_fs_group" {
  type        = number
  description = ""
  default     = 1000
}
variable "haproxy_run_as_non_root" {
  type        = bool
  description = ""
  default     = true
}
variable "haproxy_run_as_user" {
  type        = number
  description = ""
  default     = 1000
}

###########################
## ArgoCD Configurations ##
###########################
variable "argocd_version" {
  type        = string
  description = "The version of ArgoCD to deploy."
  default     = "1.7.6"
}
variable "argocd_server_image" {
  type        = string
  description = ""
  default     = "argoproj/argocd"
}
variable "argocd_repo_image" {
  type        = string
  description = ""
  default     = "argoproj/argocd"
}
variable "argocd_fs_group" {
  type        = number
  description = ""
  default     = 1000
}
variable "argocd_run_as_non_root" {
  type        = bool
  description = ""
  default     = true
}
variable "argocd_run_as_user" {
  type        = number
  description = ""
  default     = 1000
}

########################
## Redis Configurations ##
########################
variable "redis_image" {
  type        = string
  description = ""
  default     = "redis"
}
variable "redis_version" {
  type        = string
  description = "The version of Redis to deploy."
  default     = "5.0.8-alpine"
}
variable "redis_fs_group" {
  type        = number
  description = ""
  default     = 1000
}
variable "redis_run_as_non_root" {
  type        = bool
  description = ""
  default     = true
}
variable "redis_run_as_user" {
  type        = number
  description = ""
  default     = 1000
}

########################
## Dex Configurations ##
########################
variable "dex_image" {
  type        = string
  description = ""
  default     = "dexidp/dex"
}
variable "dex_version" {
  type        = string
  description = "The version of Dex to deploy."
  default     = "2.25.0"
}
variable "dex_fs_group" {
  type        = number
  description = ""
  default     = 1000
}
variable "dex_run_as_non_root" {
  type        = bool
  description = ""
  default     = true
}
variable "dex_run_as_user" {
  type        = number
  description = ""
  default     = 1000
}