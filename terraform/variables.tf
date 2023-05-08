variable "compute_engine_machine_type" {
  type = string
  default = "f1-micro"
}

variable "compute_engine_credentials" {
  type = string
  default = "service_account.json"
}

variable "compute_engine_project" {
  type = string
  default = "practice-385014"
}

variable "compute_engine_region" {
  type = string
  default = "us-central1"
}

variable "compute_engine_zone" {
  type = string
  default = "us-central1-c"
}

variable "compute_engine_image" {
  type = string
  default = "centos-cloud/centos-7"
}