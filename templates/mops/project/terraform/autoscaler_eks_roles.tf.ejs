---
to: terraform/autoscaler_eks_roles.tf
---
locals {
    eks_cluster_autoscaler_service_account_name = "sa-cluster-autoscaler"
}

# Create ISRA Role for Cluster Autoscaler
module "cluster_autoscaler_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name                        = "${local.eks_iam_role_prefix}-cluster-autoscaler"
  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_names = [module.eks.cluster_name]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:${local.eks_cluster_autoscaler_service_account_name}"]
    }
  }
}

# Create K8S Service Account for Cluster Autoscaler
resource "kubernetes_service_account" "cluster_autoscaler_service_account" {
  metadata {
    name      = local.eks_cluster_autoscaler_service_account_name
    namespace = "kube-system"

    labels = {
      "app.kubernetes.io/name" = local.eks_cluster_autoscaler_service_account_name
      "k8s-addon"              = "cluster-autoscaler.addons.k8s.io"
      "k8s-app"                = "cluster-autoscaler"
    }

    annotations = {
      "eks.amazonaws.com/role-arn" = module.cluster_autoscaler_irsa_role.iam_role_arn
    }
  }

  depends_on = [
    module.eks,
    aws_eks_node_group.eks
  ]
}

# Output EKS Service Account for Cluster AutoScaler
output "eks_sa_cluster_autoscaler_name" {
  value = kubernetes_service_account.cluster_autoscaler_service_account.metadata[0].name
}

output "eks_sa_cluster_autoscaler_iam_role_arn" {
  value = module.cluster_autoscaler_irsa_role.iam_role_arn
}


