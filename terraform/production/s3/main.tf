resource "aws_s3_bucket" "avatar" {
  bucket = var.bucket_name
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "avatar_access" {
  depends_on = [
    aws_s3_bucket_policy.avatar_policy
  ]
  bucket = aws_s3_bucket.avatar.id
}

resource "aws_s3_bucket_policy" "avatar_policy" {
  bucket = aws_s3_bucket.avatar.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowPublicRead"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "s3:*",
        Resource = [
          aws_s3_bucket.avatar.arn,
          "${aws_s3_bucket.avatar.arn}/*"
        ]
      },
    ]
  })
}
