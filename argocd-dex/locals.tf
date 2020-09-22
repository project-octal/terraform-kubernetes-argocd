locals {
  image_repository = var.image_repository == null ? "quay.io" : var.image_repository
}