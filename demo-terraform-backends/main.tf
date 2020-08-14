provider "aws" {
  region="us-east-1"
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt state files"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "terraform-backend" {
  bucket=var.backend_bucket_name
  acl=var.bucket_acl
  tags=var.bucket_tags
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

output "arn" {
    value = aws_kms_key.mykey.arn
}