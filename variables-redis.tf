#########################
## Redis Configuration ##
#########################
variable "redis_image" {
  type        = string
  description = ""
  default     = "library/redis"
}
variable "redis_version" {
  type        = string
  description = "The version of the Redis Docker image to deploy."
  default     = "5.0.8-alpine"
}
variable "redis_fs_group" {
  type        = number
  description = ""
  default     = 1000
}
variable "redis_run_as_non_root" {
  type        = bool
  description = ""
  default     = true
}
variable "redis_run_as_user" {
  type        = number
  description = ""
  default     = 1000
}