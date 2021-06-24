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
  tags = concat(
    ["http-server", "https-server", "demo-2021-06-23"],
    ["meta-app-${var.environment}", var.environment],
    var.custom_tags,
  )
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

# resource "google_dns_record_set" "app-dns" {
#   project      = var.project
#   name         = "meta-${var.environment}.${var.region}.${var.zone_name}"
#   type         = "A"
#   ttl          = 60
#   managed_zone = var.zone_link
#   rrdatas      = [google_compute_instance.instance.network_interface.0.access_config.0.nat_ip]
# }
