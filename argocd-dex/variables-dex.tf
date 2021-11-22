###########################
## General Configuration ##
###########################
variable "namespace" {
  type = string
}
variable "image_pull_policy" {
  type = string
}
variable "labels" {
  type = map(string)
}
variable "argocd_image_tag" {
  type = string
}
variable "argocd_image_name" {
  type = string
}
variable "argocd_image_repository" {
  type = string
}

#######################
## Dex Configuration ##
#######################
variable "dex_image_tag" {
  type = string
}
variable "dex_image_name" {
  type = string
}
variable "dex_image_repository" {
  type = string
}