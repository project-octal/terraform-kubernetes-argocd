resource "kubernetes_deployment" "argocd_dex_server" {
  metadata {
    name = "argocd-dex-server"
    labels = merge({
      "app.kubernetes.io/name": "argocd-dex-server"
      "app.kubernetes.io/component": "dex-server"
      "app.kubernetes.io/part-of": "argocd"
    }, var.labels)
  }
  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name": "argocd-dex-server"
      }
    }
    template {
      metadata {
        labels = merge({
          app.kubernetes.io/name: argocd-dex-server
        }, var.labels)
      }
      spec {
        service_account_name = kubernetes_service_account.argocd_dex_server.metadata.0.name
        # TODO: Add this!
        security_context {}
        container {
          name = "dex"
          image = "${var.image_repository}/${var.dex_image}:${var.dex_version}"
          image_pull_policy = var.image_pull_policy
          command = ["/shared/argocd-util", "rundex"]
          # TODO: Add these!
          resources {}
          liveness_probe {}
          readiness_probe {}
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
            name = "static-files"
            mount_path = "/shared"
          }
        }
        init_container {
          name = "copyutil"
          image = "${var.image_repository}/${var.dex_image}:${var.dex_version}"
          image_pull_policy = var.image_pull_policy
          command = ["cp", "-n", "/usr/local/bin/argocd-util", "/shared"]
          # TODO: Add these!
          resources {}
          volume_mount {
            name = "static-files"
            mount_path = "/shared"
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