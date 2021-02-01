resource "aws_s3_bucket" "b" {
  bucket = "constable-odos-bucket"
  acl    = "public-read"
  policy = file("policy.json")

  versioning {
    enabled = true
    mfa_delete = true
  }
  
  server_side_encryption_configuration {
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

  website {
    index_document = "pleasehireme.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]

resource "aws_s3_bucket" "b" {
  bucket = "my-log-bucket"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}

}
EOF
  }
}
