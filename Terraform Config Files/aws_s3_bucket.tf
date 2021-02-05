resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  is_enabled              = true
  enable_key_rotation    = true
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "bridgecreweval-logging-bucket"
  acl    = "log-delivery-write"
  
  versioning {
    enabled = true
  }
    
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "constable-odos-bucket"
  acl    = "public-read"
  
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
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
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
