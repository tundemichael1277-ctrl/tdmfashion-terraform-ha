# Create the IAM Role with an EC2 Trust Policy
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-access-role"

  # This allows the EC2 service to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Create the S3 Access Policy (Least Privilege)
resource "aws_iam_policy" "s3_access_policy" {
  name        = "ec2-s3-bucket-access-policy"
  description = "Allows EC2 instance to list and read/write to specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # Actions applied to the bucket itself
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          "*"
        ]
      },
      {
        # Actions applied to the items inside the bucket
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "*"
        ]
      }
    ]
  })
}

# Attach the Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Create the Instance Profile (The mandatory wrapper for EC2)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-instance-profile"
  role = aws_iam_role.ec2_s3_role.name
}

