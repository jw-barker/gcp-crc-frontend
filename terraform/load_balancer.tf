resource "google_compute_backend_bucket" "static_backend" {
  name        = "staticsite-backend-bucket"
  bucket_name = google_storage_bucket.static_site.name
  enable_cdn  = true
}

resource "google_compute_url_map" "static_site" {
  name            = "staticsite-lb-url-map"
  default_service = google_compute_backend_bucket.static_backend.id
}

resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "staticsite-https-proxy"
  url_map          = google_compute_url_map.static_site.id
  ssl_certificates = [google_compute_managed_ssl_certificate.static_site_cert.id]
}

resource "google_compute_global_forwarding_rule" "https_rule" {
  name       = "staticsite-https-forwarding-rule"
  target     = google_compute_target_https_proxy.https_proxy.id
  ip_address = var.static_ip
  port_range = "443"
}
