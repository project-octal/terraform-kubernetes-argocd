###########################
## HAProxy Configuration ##
###########################
variable "haproxy_image_tag" {
  type        = string
  description = "Defines which docker image tag to use for HAProxy"
  default     = "2.0.4"
}
variable "haproxy_image_name" {
  type        = string
  description = ""
  default     = "library/haproxy"
}

#########################
## Redis Configuration ##
#########################
variable "redis_image_tag" {
  type        = string
  description = "The version of the Redis Docker image to deploy."
  default     = "5.0.8-alpine"
}
variable "redis_image_name" {
  type        = string
  description = ""
  default     = "library/redis"
}