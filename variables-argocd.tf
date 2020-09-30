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

#variable "argocd_fs_group" {
#  type        = number
#  description = "Sets the ownership and permissions for the contents of each mounted volume."
#  default     = 1000
#}
#variable "argocd_run_as_non_root" {
#  type        = bool
#  description = ""
#  default     = true
#}
#variable "argocd_run_as_user" {
#  type        = number
#  description = ""
#  default     = 1000
#}

variable "repository_credentials" {
  type        = list(map(any))
  description = "A list of git repositories that ArgoCD will be configured to use."
  default     = []
}
variable "argocd_git_repositories" {
  type        = list(map(any))
  description = "A list of credentials that ArgoCD will use when pulling from configured repositories."
  default     = []
}
variable "argocd_repositories" {
  type        = list(map(any))
  description = "A list of repositories that ArgoCD might pull from."
  default     = []
}
variable "argocd_repository_credentials" {
  type        = list(map(any))
  description = "A list of repositories that ArgoCD might pull from."
  default     = []
}