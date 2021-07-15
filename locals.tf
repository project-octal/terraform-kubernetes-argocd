locals {
  labels = merge({
    "app.kubernetes.io/part-of" : "argocd"
    # Some more labels go here...
  }, var.labels)

  argocd_repo_requests_cpu    = var.argocd_repo_requests.cpu == null ? "50m" : var.argocd_repo_requests.cpu
  argocd_repo_requests_memory = var.argocd_repo_requests.memory == null ? "32Mi" : var.argocd_repo_requests.memory

  argocd_repo_limits_cpu    = var.argocd_repo_limits.cpu == null ? "100m" : var.argocd_repo_limits.cpu
  argocd_repo_limits_memory = var.argocd_repo_limits.memory == null ? "64Mi" : var.argocd_repo_limits.memory


  argocd_server_requests_cpu    = var.argocd_server_requests.cpu == null ? "50m" : var.argocd_server_requests.cpu
  argocd_server_requests_memory = var.argocd_server_requests.memory == null ? "64Mi" : var.argocd_server_requests.memory

  argocd_server_limits_cpu    = var.argocd_server_limits.cpu == null ? "100m" : var.argocd_server_limits.cpu
  argocd_server_limits_memory = var.argocd_server_limits.memory == null ? "128Mi" : var.argocd_server_limits.memory

    resource.customizations: |
    argoproj.io/Application:
      health.lua: |
        hs = {}
        hs.status = "Progressing"
        hs.message = ""
        if obj.status ~= nil then
          if obj.status.health ~= nil then
            hs.status = obj.status.health.status
            if obj.status.health.message ~= nil then
              hs.message = obj.status.health.message
            end
          end
        end
        return hs
}