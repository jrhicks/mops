---
to: terraform/locals.tf
---
locals {
  # AWS Provider
  aws_region = "<%= aws_region %>"
  aws_profile = "<%=platform_name%>"
  public_domain = "<%= public_domain %>"

  # Account ID
  account_id = data.aws_caller_identity.current.account_id

  # Tags
  project = "<%=platform_name%>"

  # VPC Configuration
  vpc_name = "<%=platform_name%>-vpc"
  vpc_cidr = "<%= aws_vpc_cidr %>"
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  # EKS Configuration
  eks_cluster_name = "<%=platform_name%>-cluster"
  eks_cluster_version = "1.28"
  eks_iam_role_prefix = "sa-<%=platform_name%>"
}