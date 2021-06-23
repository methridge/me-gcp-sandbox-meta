data "google_compute_zones" "zones" {
  project = var.project
  region  = var.region
}

data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}
