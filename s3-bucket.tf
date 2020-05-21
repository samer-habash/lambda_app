resource "aws_kms_key" "samh-kms" {
  description             = "Sam KMS for S3 buckets"
  deletion_window_in_days = 7
  enable_key_rotation = true
}

resource "aws_s3_bucket" "assets" {
  bucket = "samh-assets"
  acl = "public-read"
  versioning {
    enabled = true
  }
  tags = {
    For = "AWS_Lambda"
  }
}

//resource "aws_s3_bucket_public_access_block" "assets" {
//  bucket = aws_s3_bucket.assets.id
//  block_public_acls = true
//  restrict_public_buckets = true
//}

resource "aws_s3_bucket_object" "app-file" {
  bucket = aws_s3_bucket.assets.id
  key = "app.zip"
  acl = "public-read"
  # Direct download file : wget --no-check-certificate 'https://drive.google.com/u/0/uc?id=1OVQOWUBuZoSnjf0WREUNbbb2vBsgUgR0&export=download' -O app.zip
  # The source doesn't download URL , only file path.
  source = "app.zip"
  kms_key_id = aws_kms_key.samh-kms.arn
}