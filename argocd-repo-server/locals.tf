locals {
  labels = merge({
    "app.kubernetes.io/component" : var.component
    # Some more labels go here...
  }, var.labels)
}




#locals {
#  argocd_plugins = defaults(var.argocd_plugins, {    
#    image_repository = var.image_repository
#    image_name = var.image_name
#    image_tag = var.image_tag
#    image_pull_policy = var.image_pull_policy
#  })
#}

