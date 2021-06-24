output "meta-ip" {
  value = "http://${google_compute_instance.instance.network_interface.0.access_config.0.nat_ip}"
}

# output "meta-url" {
#   value = "http://${google_dns_record_set.app-dns.name}"
# }
