---
to: terraform/public_domain.tf
---
resource "aws_route53_zone" "public_domain" {
  name = local.public_domain
}

output "hosted_zone_id" {
  value = aws_route53_zone.public_domain.zone_id
}