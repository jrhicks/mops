---
to: terraform/provider.tf
---
terraform {

  backend "s3" {
    bucket         = "<%=platform_name%>-terraform-be"
    key            = "state"    
    region         = "<%=aws_region%>"
    profile        = "<%=platform_name%>"
    encrypt        = true
    dynamodb_table = "<%=platform_name%>-terraform-be"
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region  = local.aws_region
  profile = local.aws_profile

  default_tags {
    tags = {
      Project     = local.project
      Provisoner  = "Terraform"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

