data "kubernetes_secret" "argocd_default_secret" {
  metadata {
    name = kubernetes_service_account.argocd_server.default_secret_name
  }
}
provider "argocd" {
  server_addr = "${kubernetes_service.argocd_server.metadata.0.name}.${kubernetes_service.argocd_server.metadata.0.namespace}.svc" # env ARGOCD_SERVER
  auth_token  =  base64decode(data.kubernetes_secret.argocd_default_secret.data["token"])     # env ARGOCD_AUTH_TOKEN
  insecure    = true              # env ARGOCD_INSECURE
}