###########################
## HAProxy Configuration ##
###########################
variable "haproxy_image" {
  type        = string
  description = ""
  default     = "library/haproxy"
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