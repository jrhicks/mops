---
to: terraform/alb_eks_roles.tf
---
# Create IAM Role for AWS ALB Service Account

locals {
    eks_alb_service_account_name = "sa-aws-load-balancer-controller"   
}

module "load_balancer_controller_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name                              = "${local.eks_iam_role_prefix}-load-balancer-controller"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:${local.eks_alb_service_account_name}"]
    }
  }
}

# Create K8S Service Account for AWS ALB Helm Chart
resource "kubernetes_service_account" "alb_service_account" {
  
  metadata {
    name      = local.eks_alb_service_account_name
    namespace = "kube-system"

    labels = {
      "app.kubernetes.io/name"      = local.eks_alb_service_account_name
      "app.kubernetes.io/component" = "controller"
    }

    annotations = {
      "eks.amazonaws.com/role-arn"               = module.load_balancer_controller_irsa_role.iam_role_arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }

  depends_on = [
    null_resource.account_id_check,
    module.eks,
    aws_eks_node_group.eks
  ]
}

# Output EKS Service Account for AWS Load Balancer Controller
output "eks_sa_alb_name" {
  value = kubernetes_service_account.alb_service_account.metadata[0].name
}

output "eks_sa_alb_iam_role_arn" {
  value = module.load_balancer_controller_irsa_role.iam_role_arn
}
