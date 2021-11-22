terraform {
  required_version = ">= 0.14, < 2.0.0"
  experiments      = [module_variable_optional_attrs]
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.6.1"
    }
    k8s = {
      source  = "banzaicloud/k8s"
      version = "0.8.0"
    }
  }
}