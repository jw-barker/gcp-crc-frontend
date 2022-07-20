# Website resources
resource "aws_s3_object" "html" {
  bucket = "jw-barker"
  key    = "index.html"
  source = ".dist/index.html"
}

resource "aws_s3_object" "js" {
  bucket = "jw-barker"
  key    = "script.js"
  source = ".dist/script.js"
}

resource "aws_s3_object" "css" {
  bucket = "jw-barker"
  key    = "style.css"
  source = ".dist/style.css"

}