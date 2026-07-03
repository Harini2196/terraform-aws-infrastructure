resource "aws_s3_bucket" "alc_logs" {
  bucket = "${local.name_prefix}-alc-logs-${data.aws_caller_identity.current.account_id}"

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-alc-logs" })
}

resource "aws_s3_bucket_ownership_controls" "alc_logs" {
  bucket = aws_s3_bucket.alc_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "alc_logs" {
  bucket = aws_s3_bucket.alc_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "alc_logs" {
  bucket = aws_s3_bucket.alc_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "alc_logs" {
  bucket = aws_s3_bucket.alc_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "alc_logs" {
  bucket = aws_s3_bucket.alc_logs.id

  rule {
    id     = "expire-alc-logs"
    status = "Enabled"

    filter {}

    expiration {
      days = var.log_expiration_days
    }

    noncurrent_version_expiration {
      noncurrent_days = var.log_expiration_days
    }
  }
}

# Allows the regional ELB service account (legacy log delivery) and the
# logdelivery.elasticloadbalancing.amazonaws.com service principal (current
# log delivery method) to write ALB access logs into this bucket.
# NOTE: "AWSLogs" below is a literal path segment required by AWS - do not rename it.
resource "aws_s3_bucket_policy" "alc_logs" {
  bucket = aws_s3_bucket.alc_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowALBLogDeliveryLegacy"
        Effect = "Allow"
        Principal = {
          AWS = data.aws_elb_service_account.main.arn
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.alc_logs.arn}/alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
      },
      {
        Sid    = "AllowALBLogDeliveryService"
        Effect = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.alc_logs.arn}/alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.alc_logs]
}

# IAM role/instance profile allowing EC2 instances to write their own
# application logs into the same bucket, under a separate prefix.
resource "aws_iam_role" "ec2_alc_logs" {
  name = "${local.name_prefix}-ec2-alc-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { Service = "ec2.amazonaws.com" }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy" "ec2_alc_logs" {
  name = "${local.name_prefix}-ec2-alc-logs-policy"
  role = aws_iam_role.ec2_alc_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject"]
        Resource = "${aws_s3_bucket.alc_logs.arn}/app-logs/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_alc_logs" {
  name = "${local.name_prefix}-ec2-alc-logs-profile"
  role = aws_iam_role.ec2_alc_logs.name
}
