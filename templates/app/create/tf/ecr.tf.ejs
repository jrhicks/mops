---
to: terraform/app-<%=app_name%>-ecr.tf
---
# ECR Repository

resource "aws_ecr_repository" "<%=repo_underscored%>" {
  name                 = "<%=repo_dasherized%>"
  image_tag_mutability = "IMMUTABLE"
}

# IAM Policy for ECR - Allows pushing images to the repository
resource "aws_iam_user_policy" "<%=repo_underscored%>_write_policy" {
  name        = "<%=repo_dasherized%>-write-policy"
  user        = aws_iam_user.<%=repo_underscored%>_gh_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:GetAuthorizationToken",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource = aws_ecr_repository.<%=repo_underscored%>.arn
      }
    ]
  })
  depends_on              = [module.vpc, aws_iam_user.<%=repo_underscored%>_gh_user]

}

resource "aws_iam_user_policy" "<%=repo_underscored%>_auth_policy" {
  name        = "<%=repo_dasherized%>-auth-policy"
  user        = aws_iam_user.<%=repo_underscored%>_gh_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetAuthorizationToken",
        ],
        Resource = "*"
      }
    ]
  })
  depends_on              = [module.vpc, aws_iam_user.<%=repo_underscored%>_gh_user]

}


# IAM User
resource "aws_iam_user" "<%=repo_underscored%>_gh_user" {
  name = "<%=repo_dasherized%>-gh-user"
}

resource "aws_iam_policy" "<%=repo_underscored%>_read_policy" {
  name        = "<%=repo_dasherized%>-read-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
        ],
        Resource = aws_ecr_repository.<%=repo_underscored%>.arn
      },
    ]
  })
}

resource "aws_iam_role" "<%=repo_underscored%>_read_role" {
  name = "<%=repo_dasherized%>-read-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "sts.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "<%=repo_underscored%>_read_role_attachment" {
  role       = aws_iam_role.<%=repo_underscored%>_read_role.name
  policy_arn = aws_iam_policy.<%=repo_underscored%>_read_policy.arn
}

