#######################
## Dex Configuration ##
#######################
variable "enable_dex" {
  type        = bool
  description = "Determines whether or not to deploy Dex alongside ArgoCD"
  default     = true
}
variable "dex_image_tag" {
  type        = string
  description = "The version of the Dex Docker image to deploy."
  default     = "2.30.0"
}
variable "dex_image_name" {
  type        = string
  description = "The name of the Dex image to use"
  default     = "dexidp/dex"
}
variable "dex_image_repository" {
  type        = string
  description = "The repository that the dex image will be obtained from"
  default     = "docker.io"
}