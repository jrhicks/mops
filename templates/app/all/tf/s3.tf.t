---
to: ./terraform/app-<%=app_name%>-<%=rails_env%>-s3.tf
---

// Create S3 bucket
resource "aws_s3_bucket" "<%=platform_name_underscored%>_<%=app_name_underscored%>_<%=rails_env%>_bucket" {
  bucket = "<%=platform_name%>-<%=app_name%>-<%=rails_env%>-bucket"
  acl = "private"
}

// Create IAM user
resource "aws_iam_user" "<%=platform_name_underscored%>_<%=app_name_underscored%>_<%=rails_env%>_bucket_user" {
  name = "<%=platform_name%>-<%=app_name%>-<%=rails_env%>-bucket-user"
}

// Define IAM policy with required permissions
resource "aws_iam_policy" "<%=platform_name_underscored%>_<%=app_name_underscored%>_<%=rails_env%>_bucket_policy" {
  name = "<%=platform_name%>-<%=app_name%>-<%=rails_env%>-bucket-policy"
  description = "Policy for S3"

  policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Action = [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:GetObjectAcl",
        "s3:PutObjectAcl"
      ]
      Effect = "Allow"
      Resource = "*"
    },
  ]
  })
}

// Attach the defined policy to the user
resource "aws_iam_user_policy_attachment" "<%=platform_name_underscored%>_<%=app_name_underscored%>_<%=rails_env%>_bucket_policy_attachment" {
  user =aws_iam_user.<%=platform_name_underscored%>_<%=app_name_underscored%>_<%=rails_env%>_bucket_user.name
  policy_arn = aws_iam_policy.<%=platform_name_underscored%>_<%=app_name_underscored%>_<%=rails_env%>_bucket_policy.arn
}