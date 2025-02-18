resource "google_compute_managed_ssl_certificate" "static_site_cert" {
  name = "staticsite-ssl"

  managed {
    domains = var.ssl_domains
  }
}
