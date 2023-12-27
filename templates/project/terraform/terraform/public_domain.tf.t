---
to: terraform/public_domain.tf
---
# Request a certificate for liftbooking.com and all subdomains
resource "aws_acm_certificate" "public_domain" {
  domain_name               = local.public_domain  # Main domain
  subject_alternative_names = ["*.${local.public_domain}"]  # Wildcard for all subdomains
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Validate SSL Certificate using DNS for liftbooking.com and subdomains
resource "aws_route53_record" "public_domain" {
  for_each = {
    for dvo in aws_acm_certificate.public_domain.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.public_domain.zone_id  # Ensure this refers to your correct Route 53 zone
}

# Wait for the validation to complete before using the certificate
resource "aws_acm_certificate_validation" "public_domain" {
  certificate_arn         = aws_acm_certificate.public_domain.arn
  validation_record_fqdns = [for record in aws_route53_record.public_domain : record.fqdn]
}

# Output the certificate ARN for reference or other resources
output "acm_arn_public_domain" {
  value = aws_acm_certificate.public_domain.arn
}

locals {
    eks_external_dns_service_account_name = "sa-external-dns"   
}

# Create ISRA Role for External DNS
module "external_dns_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name                  = "${local.eks_iam_role_prefix}-external-dns"
  attach_external_dns_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:${local.eks_external_dns_service_account_name}"]
    }
  }
}

# Create K8S Service Account for External DNS
resource "kubernetes_service_account" "external_dns_service_account" {
  metadata {
    name      = local.eks_external_dns_service_account_name
    namespace = "kube-system"

    labels = {
      "app.kubernetes.io/name"      = local.eks_external_dns_service_account_name
      "app.kubernetes.io/component" = "controller"
    }

    annotations = {
      "eks.amazonaws.com/role-arn" = module.external_dns_irsa_role.iam_role_arn
    }
  }

  depends_on = [
    module.eks,
    aws_eks_node_group.eks
  ]
}

resource "aws_route53_zone" "public_domain" {
  name = local.public_domain
}

output "hosted_zone_id" {
  value = aws_route53_zone.public_domain.zone_id
}

