terraform {
  required_version = ">= 1.0.3"
  experiments      = [module_variable_optional_attrs]
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.0.2"
    }
    k8s = {
      source  = "banzaicloud/k8s"
      version = "0.8.0"
    }
  }
}