resource "aws_s3_bucket" "jw-barker" {
  bucket = "jw-barker"

  tags = {
    Name = "my website bucket"
  }
}

#resource "aws_s3_bucket_acl" "b_acl" {
#  bucket = aws_s3_bucket.jw-barker.id
#  acl    = "private"
#}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  price_class = "PriceClass_All"
  tags = {
    "Environment" = "production"
  }
  tags_all = {
    "Environment" = "production"
  }


  aliases = ["*.jamesbarker.uk", "jamesbarker.uk"]
  default_cache_behavior {
    cached_methods = ["GET", "HEAD"]
    allowed_methods = ["DELETE","OPTIONS","PATCH","POST","PUT","GET","HEAD"]

    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress               = true
    default_ttl            = 0
    max_ttl                = 0
    target_origin_id       = "organization-formation-515266552493.s3.eu-west-1.amazonaws.com"
    viewer_protocol_policy = "redirect-to-https"

 #   forwarded_values {
#
 #     query_string = false
#
#
 #     cookies {
 #       forward = "none"
#
 #     }
 #   }
  }

  ordered_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
      "OPTIONS",
    ]
    cached_methods = [
      "GET",
      "HEAD",
      "OPTIONS",
    ]
    compress               = true
    default_ttl            = 86400
    max_ttl                = 31536000
    min_ttl                = 0
    path_pattern           = "/content/immutable/*"
    target_origin_id       = "jw-barker.s3-website-eu-west-1.amazonaws.com"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      headers = [
        "Origin",
      ]
      query_string = false


      cookies {
        forward = "none"
      }
    }
  }
  ordered_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
      "OPTIONS",
    ]
    cached_methods = [
      "GET",
      "HEAD",
    ]
    compress               = true
    default_ttl            = 3600
    max_ttl                = 86400
    min_ttl                = 0
    path_pattern           = "/content/*"
    target_origin_id       = "jw-barker.s3-website-eu-west-1.amazonaws.com"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {

      query_string = false


      cookies {
        forward = "none"
      }
    }
  }

  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name         = "jw-barker.s3-website-eu-west-1.amazonaws.com"
    origin_id           = "organization-formation-515266552493.s3.eu-west-1.amazonaws.com"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }
  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name         = "jw-barker.s3.eu-west-1.amazonaws.com"
    origin_id           = "jw-barker.s3-website-eu-west-1.amazonaws.com"
  }

  restrictions {
    geo_restriction {
      locations = [
        "CA",
        "DE",
        "GB",
        "IR",
        "US",
      ]
      restriction_type = "whitelist"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:515266552493:certificate/82ab8495-9b1f-464d-86e9-be5be48c8dad"
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}
