---
to: terraform/data.tf
---
# Retrieve AWS Account Information
data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  name = local.eks_cluster_name

  depends_on = [module.eks.cluster_name]
}