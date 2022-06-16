variable "enable_ha_redis" {
  type    = bool
  default = false
}

###########################
## HAProxy Configuration ##
###########################
variable "haproxy_image_tag" {
  type        = string
  description = "Defines which docker image tag to use for HAProxy"
  default     = "2.6.0-alpine"
}
variable "haproxy_image_name" {
  type        = string
  description = ""
  default     = "haproxy"
}
variable "haproxy_image_repository" {
  type        = string
  description = ""
  default     = "docker.io"
}

#########################
## Redis Configuration ##
#########################
variable "redis_image_tag" {
  type        = string
  description = "The version of the Redis Docker image to deploy."
  default     = "7.0.2-alpine"
}
variable "redis_image_name" {
  type        = string
  description = ""
  default     = "redis"
}

variable "redis_image_repository" {
  type        = string
  description = ""
  default     = "docker.io"
}