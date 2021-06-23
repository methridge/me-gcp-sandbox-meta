#
# Required Variables
#

variable "app_ver" {
  type        = string
  description = "GCP Meta app version"
  default     = "0.1.3"
}

variable "environment" {
  type        = string
  description = "Application deployment environment"
}

variable "project" {
  type        = string
  description = "GCP Project name"
}

variable "region" {
  type        = string
  description = "GCP Region for Hashistack deployment"
}

variable "dnszone" {
  type        = string
  description = "DNS Zone name for LB"
  default     = ""
}

variable "zone_link" {
  type        = string
  description = "GCP Zone Object Self-link"
  default     = ""
}

variable "region_tls_priv_key" {
  type        = string
  description = "TLS Private Key"
  default     = ""
}

variable "region_tls_cert_chain" {
  type        = string
  description = "TLS Public Cert Chain"
  default     = ""
}


#
# Optional with defaults
#

variable "machine_type" {
  type        = string
  description = "Instance machine type"
  default     = "n1-standard-1"
}

variable "allowed_ips" {
  type        = list(string)
  description = "The IP address ranges which can access the load balancer."
  default     = ["0.0.0.0/0"]
}

variable "custom_tags" {
  type        = list(string)
  description = "A list of tags that will be added to the Compute Instance Template in addition to the tags automatically added by this module."
  default     = []
}
