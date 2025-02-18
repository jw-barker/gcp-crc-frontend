resource "google_storage_bucket" "static_site" {
  name          = var.bucket_name
  location      = var.bucket_location
  storage_class = "STANDARD"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"
  members = ["allUsers"]
}

resource "google_storage_bucket_object" "static_files" {
  for_each    = fileset("./website", "*")
  name        = each.value
  bucket      = google_storage_bucket.static_site.name
  source      = "./website/${each.value}"
  content_type = lookup({
    "html"  = "text/html",
    "css"   = "text/css",
    "js"    = "text/javascript",
    "jpg"   = "image/jpeg"
  }, split(".", each.value)[length(split(".", each.value))-1], "application/octet-stream")
}