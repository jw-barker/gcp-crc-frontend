# Website resources
resource "aws_s3_object" "html" {

  bucket        = "jw-barker"
  key           = "index.html"
  source        = "website/index.html"
  acl           = "public-read"
  force_destroy = true
}

resource "aws_s3_object" "js" {

  bucket        = "jw-barker"
  key           = "script.js"
  source        = "website/script.js"
  acl           = "public-read"
  force_destroy = true
}

resource "aws_s3_object" "css" {

  bucket        = "jw-barker"
  key           = "style.css"
  source        = "website/style.css"
  acl           = "public-read"
  force_destroy = true
}

resource "aws_s3_object" "image" {

  bucket        = "jw-barker"
  key           = "james.jpg"
  source        = "website/james.jpg"
  acl           = "public-read"
  force_destroy = true
}
