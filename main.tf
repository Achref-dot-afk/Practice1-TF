terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.68.0"  // Use the version you need
    }
  }
}
resource "google_compute_instance" "example" {
  name         = "instance-1"
  machine_type = "n2-standard-2"

  zone = var.gcp_zone

  tags = ["allow-traffic3000"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
     access_config {
      nat_ip = google_compute_address.instance_ip.address
    }
  }
  metadata_startup_script = "sudo apt-get update && sudo apt-get install -y nodejs npm && git clone https://github.com/your/nodejs-app.git && cd nodejs-app && npm install && npm start"
}

resource "google_compute_firewall" "default" {
  name    = "firewall-1"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  target_tags   = ["allow-traffic3000"]
}
resource "google_compute_address" "instance_ip" {
  name = "instance-ip"
}
