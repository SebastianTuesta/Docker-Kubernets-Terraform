
variable "gke_credentials" {
  type = string
  default = "service_account.json"
}

variable "gke_project" {
  type = string
  default = "practice-385014"
}

variable "gke_region" {
  type = string
  default = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  default = "my-cluster"
}