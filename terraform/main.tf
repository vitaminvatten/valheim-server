#Service account for Server will use
resource "google_service_account" "Valheim_svc" {
  account_id   = var.service_name
  display_name = var.service_name
  project      = var.project
}


#Server
resource "google_compute_instance" "valheim-server" {
  name           = var.server_name
  machine_type   = var.machine_type


  tags = ["valheim-fw"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = file("./startup.sh")


  network_interface {
    network = var.VPC
    access_config {}
  }

  service_account {
    email  = google_service_account.Valheim_svc.email
    scopes = ["cloud-platform"]
  }
}



#firewall
resource "google_compute_firewall" "valheim-fw" {
  name    = "valheim-fw"
  network = var.VPC

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["2456", "2457", "2458"]
  }

  target_tags = ["valheim-fw"]
}