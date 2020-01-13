resource "kubernetes_service" "admin-app" {
  metadata {
    name = "${var.workspace}-admin-app-deploy"
  }
  spec {
    selector = {
      app = "${var.workspace}-admin-app"
    }
    port {
      port        = 80
      protocol    = "TCP"
      target_port = 3000
    }

    type = "NodePort"
  }
}

locals {
  image = "koa-app:v1"
  selector_labels = {
    app = "${var.workspace}-admin-app"
  }
}

resource "kubernetes_deployment" "terraform-kube-deploy" {
  metadata {
    name   = "${var.workspace}-admin-app-deploy"
    labels = local.selector_labels
    annotations = {
      workspace = terraform.workspace
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = local.selector_labels
    }

    template {
      metadata {
        labels = local.selector_labels
      }

      spec {
        container {
          image = "scg-home-cms:1.0"
          name  = "admin-cms"

          env {
            name  = "PORT"
            value = "3000"
          }

          command = ["yarn", "start"]

          # resources {
          #   limits {
          #     cpu    = "0.5"
          #     memory = "512Mi"
          #   }
          #   requests {
          #     cpu    = "250m"
          #     memory = "50Mi"
          #   }
          # }

          liveness_probe {
            http_get {
              path = "/"
              port = 3000

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
