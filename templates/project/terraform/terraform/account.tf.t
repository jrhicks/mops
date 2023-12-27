---
to: terraform/account.tf
---
variable "aws_account_id" {
  description = "AWS Account ID for <%=platform_name%>"
  type        = string
  default     = "<%= aws_account_id %>"
}

locals {
  account_id_check = data.aws_caller_identity.current.account_id == var.aws_account_id ? true : false
}

resource "null_resource" "account_id_check" {
  # The count parameter in a Terraform resource block determines 
  # how many instances of that resource to create. 
  # If count is set to 0, no instances of the resource will be created.
  # If count is set to 1, one instance of the resource will be created.  
  
  # Count of 1 will cause provisioner to run and terminate the apply
  count = local.account_id_check == true ? 0 : 1

  provisioner "local-exec" {
    command = "echo 'HALTING! AWS Account ID doesn't match <%= platform_name %>'; exit 1"
  }
}

