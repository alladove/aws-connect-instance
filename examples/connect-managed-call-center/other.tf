resource "aws_s3_bucket" "connect" {
  bucket = "${local.instance_alias}-data"

  tags = local.tags
}

resource "aws_s3_bucket_versioning" "connect" {
  bucket = aws_s3_bucket.connect.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "connect" {
  bucket = aws_s3_bucket.connect.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "connect" {
  bucket = aws_s3_bucket.connect.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
