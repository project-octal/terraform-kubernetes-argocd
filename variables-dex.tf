#######################
## Dex Configuration ##
#######################
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