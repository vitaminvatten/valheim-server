terraform {
  required_version = ">=0.14"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.0"
    }
  }
}

provider "google" {
  region      = var.region[0]
  zone        = var.zone[0]
  project     = var.project
}
