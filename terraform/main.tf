#Service account for Server will use
resource "google_service_account" "Valheim_svc" {
  account_id   = var.service_name
  display_name = var.service_name
  project      = var.project
}

resource "google_compute_address" "valheim-server-ip" {
  name         = "valheim-server-ip"
  address_type = "EXTERNAL"
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
    access_config {
      nat_ip = google_compute_address.valheim-server-ip.address
    }
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
    protocol = "udp"
    ports    = ["2456", "2457"]
  }

  target_tags = ["valheim-fw"]
}