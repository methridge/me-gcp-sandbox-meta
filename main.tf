###
### Region Bastion Host
###
resource "google_compute_instance" "instance" {
  name         = "${var.region}-instance-${var.environment}"
  machine_type = var.machine_type
  project      = var.project
  zone         = data.google_compute_zones.zones.names[0]
  metadata_startup_script = templatefile(
    "${path.module}/templates/startup.sh",
    { app_ver = var.app_ver, }
  )
  tags = concat(["http-server", "https-server"], [var.environment], var.custom_tags)
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  service_account {
    email  = null
    scopes = ["cloud-platform"]
  }
}

# module "region-dns" {
#   source     = "../region-dns"
#   project    = var.project
#   region     = var.region
#   dnszone    = var.dnszone
#   zone-name  = var.zone_link
#   bastion-ip = google_compute_instance.region_bastion.network_interface.0.access_config.0.nat_ip
#   lb-ip      = google_compute_address.region-pub-ip.address
#   glb-ip     = module.global-https-lb.region-lb-global-ip
# }
