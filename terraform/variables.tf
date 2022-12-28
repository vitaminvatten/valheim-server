variable "service_name" {}

variable "project" {}

variable "server_name" {}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}
variable "VPC" {
  type    = string
  default = "default"
}

variable "region" {
  type = list(any)
  default = ["europe-west1"]
}

variable "zone" {
  type = list(any)
  default = ["europe-west1-b"]
}