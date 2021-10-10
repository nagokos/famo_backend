resource "aws_s3_bucket" "bucket1" {
  # bucket = ""
  acl = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id
}

resource "aws_s3_bucket_policy" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowPublicRead"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "s3:*"
        Resource = [
          aws_s3_bucket.bucket1.arn,
          "${aws_s3_bucket.bucket1.arn}/*"
        ]
      },
    ]
  })
}
