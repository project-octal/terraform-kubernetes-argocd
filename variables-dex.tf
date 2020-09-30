#######################
## Dex Configuration ##
#######################
variable "dex_image" {
  type        = string
  description = ""
  default     = "dexidp/dex"
}
variable "dex_version" {
  type        = string
  description = "The version of the Dex Docker image to deploy."
  default     = "2.25.0"
}