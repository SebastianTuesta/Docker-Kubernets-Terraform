provider "google" {
  version                 = "3.5.0"
  credentials             = file(var.compute_engine_credentials)
  project                 = var.compute_engine_project
  region                  = var.compute_engine_region
  zone                    = var.compute_engine_zone
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
}

resource "google_compute_firewall" "allow-http-ssh" {
  name                    = "allow-http-ssh"
  network                 = google_compute_network.vpc_network.name
  allow {
    protocol              = "tcp"
    ports                 = ["80", "22"]
  }
  source_ranges           = ["0.0.0.0/0"]
  target_tags             = ["allow-http-ssh"]
}

resource "google_compute_instance" "vm_instance" {
  name                    = "terraform-instance2"
  machine_type            = var.compute_engine_machine_type
  zone                    = var.compute_engine_zone
  tags                    = google_compute_firewall.allow-http-ssh.target_tags

  metadata                = {
    startup-script = <<-EOF
#!/bin/bash
sudo echo "Instalando Docker"
sudo yum -y update
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker

sudo echo "Download Git"
sudo git clone https://github.com/SebastianTuesta/Docker-Kubernets-Terraform.git
cd Docker-Kubernets-Terraform/make/docker
sudo rm build_run
sudo make build_run

exit 0
    EOF
  }


  boot_disk {
    initialize_params {
      image = var.compute_engine_image
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
