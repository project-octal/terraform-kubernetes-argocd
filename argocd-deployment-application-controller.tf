resource "kubernetes_service_account" "argocd_application_controller" {
  metadata {
    name      = "argocd-application-controller"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
}

resource "kubernetes_role" "argocd_application_controller" {
  metadata {
    name      = "argocd-application-controller"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  rule {
    api_groups = [""]
    resources  = ["secrets", "configmaps"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "list"]
  }
  rule {
    api_groups = ["argoproj.io"]
    resources  = ["applications", "appprojects"]
    verbs      = ["create", "get", "list", "watch", "update", "patch", "delete"]
  }
}

resource "kubernetes_role_binding" "argocd_application_controller" {
  metadata {
    name      = "argocd-application-controller"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.argocd_application_controller.metadata.0.name
  }
  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.argocd_application_controller.metadata.0.name
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
  }
}

resource "kubernetes_cluster_role" "argocd_application_controller" {
  metadata {
    name = "argocd-application-controller"
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
  rule {
    non_resource_urls = ["*"]
    verbs             = ["*"]
  }
}

resource "kubernetes_deployment" "argocd_application_controller" {
  metadata {
    name      = "argocd-application-controller"
    namespace = kubernetes_namespace.argocd_namespace.metadata.0.name
    labels = merge({
      "app.kubernetes.io/name" : "argocd-application-controller"
      "app.kubernetes.io/component" : "application-controller"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" : "argocd-application-controller"
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : "argocd-application-controller"
        }, var.labels)
      }
      spec {
        service_account_name = kubernetes_service_account.argocd_application_controller.metadata.0.name
        # TODO: Add this!
        security_context {}
        container {
          name              = "argocd-application-controller"
          image             = "${var.image_repository}/${var.argocd_repo_image}:v${var.argocd_version}"
          image_pull_policy = var.image_pull_policy
          command = [
            "argocd-application-controller",
            "--status-processors",
            "20",
            "--operation-processors",
            "10",
            "--redis",
            "argocd-redis-ha-haproxy:6379"
          ]
          # TODO: Resource requirements will need to be declared
          resources {}
          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8082
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          readiness_probe {
            http_get {
              path = "/healthz"
              port = 8082
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          port {
            container_port = 8082
          }
        }
      }
    }
  }
}