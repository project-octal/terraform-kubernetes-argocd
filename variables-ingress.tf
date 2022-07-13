
variable "ingress_host" {
  type        = string
  description = "Argo CD's externally facing host. Required when configuring SSO"
  default     = ""
}
variable "ingress_path" {
  type        = string
  description = "A string or an extended POSIX regular expression as defined by IEEE Std 1003.1"
  default     = "/"
}
variable "ingress_enabled" {
  type        = bool
  description = "If set to `true` an ingress route will be created for ArgoCD"
  default     = false
}
variable "ingress_class_name" {
  type        = string
  description = "The ingress class that the ArgoCD ingress record should reference."
  default     = ""
}
variable "ingress_annotations" {
  type        = map(string)
  description = "A map of annotations to add to the ingress resource"
  default     = {}
}
variable "ingress_cert_issuer_annotation" {
  type        = map(string)
  description = "The cluster certificate issuer to use when creating a TLS certificate for the ingress. needs to be set here so the tls block is defined on the ingress resource."
  default     = {}
}