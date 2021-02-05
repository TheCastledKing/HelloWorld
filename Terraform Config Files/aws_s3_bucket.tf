resource "aws_s3_bucket" "log_bucket" {
  bucket = "bridgecreweval-logging-bucket"
  acl    = "log-delivery-write"
  
  versioning {
    enabled = true
  }
    
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "constable-odos-bucket"
  acl    = "public-read"
  policy = file("policy.json")
  
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  } 
  
  versioning {
    enabled = true
  }
    
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
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
EOF
  }
}
