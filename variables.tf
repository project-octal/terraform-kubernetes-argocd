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
variable "replicas" {
  type        = number
  description = "The number of replicas."
}
variable "container_networking" {
  type        = object({ type : string, port : number, container_port : number, whitelist_cidr : string, security_groups : list(string) })
  description = "An object that describes the service."
}
variable "labels" {
  type        = map(string)
  description = "Extra Kubernetes labels to include with the resources created by this module"
  default     = {}
}