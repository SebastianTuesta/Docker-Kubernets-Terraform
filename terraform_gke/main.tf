provider "google" {
  credentials = file(var.gke_credentials)
  project     = var.gke_project
  region      = var.gke_region
}

resource "google_container_cluster" "gke_cluster" {
  name               = var.cluster_name
  location           = var.gke_region
  initial_node_count = 1

  node_config {
    machine_type = "n1-standard-1"
  }
}

data "google_client_config" "current" {}

provider "kubernetes" {
  host  = "https://${google_container_cluster.gke_cluster.endpoint}"

  cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)
  token = data.google_client_config.current.access_token
}

resource "kubernetes_deployment" "api" {
  metadata {
    name = "app-deployment"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "app"
      }
    }

    template {
      metadata {
        labels = {
          app = "app"
        }
      }

      spec {
        container {
          image = "stuestag/api-test:latest"
          name  = "app"
          port {
            container_port = 8000
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "api" {
  metadata {
    name = "app-service"
  }

  spec {
    selector = {
      app = "app"
    }

    port {
      name       = "http"
      port       = 1234
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}

output "cluster_endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}

output "load_balancer_url" {
  value = "http://${kubernetes_service.api.status[0].load_balancer[0].ingress[0].ip}:${kubernetes_service.api.spec[0].port[0].port}"
}