---
to: ./terraform/app-<%=app_name%>-acm.tf
---
resource "aws_acm_certificate" "<%=sub_domain_underscored%>" {
    domain_name       = "<%=sub_domain%>.${local.public_domain}"
    validation_method = "DNS"
  
    lifecycle {
      create_before_destroy = true
    }
  }
  
  # Validate SSL Certificate using DNS for Weave Gitops
  resource "aws_route53_record" "<%=sub_domain_underscored%>_validation" {
    for_each = {
      for dvo in aws_acm_certificate.<%=sub_domain_underscored%>.domain_validation_options : dvo.domain_name => {
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
    zone_id         = aws_route53_zone.public_domain.zone_id
  }
  
  # Retrieve SSL Certificate ARN from AWS ACM for Weave Gitops
  resource "aws_acm_certificate_validation" "<%=sub_domain_underscored%>" {
    certificate_arn         = aws_acm_certificate.<%=sub_domain_underscored%>.arn
    validation_record_fqdns = [for record in aws_route53_record.<%=sub_domain_underscored%>_validation : record.fqdn]
  }

  output "acm_arn_<%=sub_domain_underscored%>" {
    value = aws_acm_certificate.<%=sub_domain_underscored%>.arn
  }
  