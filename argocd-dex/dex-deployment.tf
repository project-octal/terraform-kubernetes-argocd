resource "kubernetes_deployment" "dex_server" {
  metadata {
    name      = "argocd-dex-server"
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : "argocd-dex-server"
      "app.kubernetes.io/component" : "dex-server"
      "app.kubernetes.io/part-of" : "argocd"
    }, var.labels)
  }
  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" : "argocd-dex-server"
      }
    }

    template {

      metadata {
        labels = merge({
          "app.kubernetes.io/name" : "argocd-dex-server"
        }, var.labels)
      }
      spec {
        service_account_name            = kubernetes_service_account.dex_server.metadata.0.name
        automount_service_account_token = true
        # TODO: Add this!
        # security_context {}
        container {
          name              = "dex"
          image             = "${var.dex_image_repository}/${var.dex_image_name}:v${var.dex_image_tag}"
          image_pull_policy = var.image_pull_policy
          command = [
            "/shared/argocd-util",
            "rundex"
          ]
          # TODO: Add these!
          # resources {}
          # liveness_probe {}
          # readiness_probe {}
          port {
            container_port = 5556
          }
          port {
            container_port = 5557
          }
          port {
            container_port = 5558
          }
          volume_mount {
            name       = "static-files"
            mount_path = "/shared"
          }
        }
        init_container {
          name              = "copyutil"
          image             = "${var.argocd_image_repository}/${var.argocd_image_name}:v${var.argocd_image_tag}"
          image_pull_policy = var.image_pull_policy
          command = [
            "cp",
            "-n",
            "/usr/local/bin/argocd-util",
            "/shared"
          ]
          # TODO: Add these!
          # resources {}
          volume_mount {
            name       = "service-token"
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount/"
            read_only  = true
          }
          volume_mount {
            name       = "static-files"
            mount_path = "/shared"
          }
        }
        volume {
          name = "service-token"
          secret {
            secret_name = kubernetes_service_account.dex_server.default_secret_name
          }
        }
        volume {
          name = "static-files"
          empty_dir {}
        }
      }
    }
  }
}