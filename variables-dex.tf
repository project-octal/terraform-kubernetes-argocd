#######################
## Dex Configuration ##
#######################
variable "enable_dex" {
  type = bool
  description = "Determines whether or not to deploy Dex alongside ArgoCD"
  default = true
}
variable "dex_image_tag" {
  type        = string
  description = "The version of the Dex Docker image to deploy."
  default     = "2.25.0"
}
variable "dex_image_name" {
  type        = string
  description = ""
  default     = "dexidp/dex"
}