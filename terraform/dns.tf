resource "google_dns_managed_zone" "static_site_dns" {
  name     = "jw-barker-com"
  dns_name = "jw-barker.com."
  dnssec_config {
    state = "on"
  }
}

resource "google_dns_record_set" "static_site_a" {
  for_each     = var.dns_records
  name         = each.key
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.static_site_dns.name
  rrdatas      = [var.static_ip]
}