module "argcd_ingress_route" {
  source = "github.com/project-octal/terraform-octal-ingress-route"

  name        = var.name
  namespace   = var.namespace
  labels      = local.labels
  cert_issuer = var.cluster_cert_issuer
  dns_name    = var.argocd_url
  route_rules = [
    {
      match_rule  = "Host(`${var.argocd_url}`)"
      middlewares = []
      services = [
        {
          name      = kubernetes_service.argocd_server.metadata.0.name
          namespace = kubernetes_service.argocd_server.metadata.0.namespace
          port      = 443
          scheme    = "https"
        }
      ]
    }
  ]
}