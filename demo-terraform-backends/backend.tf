 terraform {
  backend "s3" {
    bucket = "stg-backend-terraform"
    key    = "dev"
    region = "us-east-1"
    encrypt = true
    kms_key_id = "arn:aws:kms:us-east-1:350061358007:key/60afbac0-7e27-4a17-8a89-0cd2745ffa6d"
  }
}