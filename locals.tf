locals {
  image_repository = var.image_repository == null ? "registry.hub.docker.com" : var.image_repository
}