---
to: ./terraform/app-<%=app_name%>-<%=rails_env%>-rds-sg.tf
---

# Terraform RDS FREE Tier Instance

resource "aws_security_group" "<%=platform_name_underscored%>_<%=app_name_underscored%>_rds_sg" {
  name = "<%=platform_name%>-<%=app_name%>-<%=rails_env%>-rds-sg"
  description = "Security group for RDS instance"
  vpc_id = module.vpc.vpc_id

  # Allow inbound traffic on the RDS port from private subnets
  dynamic "ingress" {
    for_each = module.vpc.private_subnets
    content {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [cidrsubnet(local.vpc_cidr, 4, ingress.key)]
    }
  }

  # Restrict egress to the private subnet CIDR blocks
  dynamic "egress" {
    for_each = module.vpc.private_subnets_cidr_blocks
    content {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [egress.value]
    }
  }

  tags = {
    Name = "<%=platform_name%>-<%=app_name%>-<%=rails_env%>-rds-sg"
  }
  depends_on = [ module.vpc ]
}