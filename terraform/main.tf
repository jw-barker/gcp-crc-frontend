###S3 Bucket###

resource "aws_s3_bucket" "jw-barker" {
  bucket = "jw-barker"

}
resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.jw-barker.id
  
    policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::jw-barker/*"
        },
        {
            "Sid": "2",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E5NVW0CDOPFF5"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::jw-barker/*"
        }
    ]
}
  EOF
  }
  
####Cloudfront####
resource "aws_cloudfront_distribution" "s3_distribution" {

  depends_on = [
    aws_s3_bucket.jw-barker
  ]
  origin {
    domain_name         = var.domain_name
    origin_id           = local.s3_origin_id
    connection_attempts = 3
    connection_timeout  = 10

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/E5NVW0CDOPFF5"
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = ["*.jamesbarker.uk", "jamesbarker.uk"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    compress         = true
    cache_policy_id  = var.cache_policy

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:515266552493:certificate/82ab8495-9b1f-464d-86e9-be5be48c8dad"
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}

locals {
  s3_origin_id = "jw-barker.s3.eu-west-1.amazonaws.com"
}

#resource "aws_s3_bucket_acl" "acl" {
#  bucket = aws_s3_bucket.jw-barker.id
#  acl    = "public-read"
#
#}

#resource "aws_s3_bucket_public_access_block" "website_bucket_public_access_block" {
#
#  bucket                  = aws_s3_bucket.jw-barker.id
#  ignore_public_acls      = false
#  block_public_acls       = false
#  restrict_public_buckets = false
#  block_public_policy     = false
#}