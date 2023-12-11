---
to: scripts/terraform_backend_destroy.sh
---
echo "Destroying Terraform Backend resources..."

echo "Removing State file from s3 bucket ..."
aws s3 rm s3://<%=platform_name%>-<%-environment%>-terraform-be/state --profile <%=platform_name%>-<%-environment%>

echo "Deleting Bucket <%=platform_name%>-<%-environment%>-terraform-be ..."  
aws s3api delete-bucket \
    --bucket <%=platform_name%>-<%-environment%>-terraform-be \
    --region <%=aws_region%> \
    --profile <%=platform_name%>-<%-environment%>


echo "Deleting Dynamo Table <%=platform_name%>-<%-environment%>-terraform-be ..."  
aws dynamodb delete-table \
    --table-name <%=platform_name%>-<%-environment%>-terraform-be \
    --region <%=aws_region%> \
    --profile <%=platform_name%>-<%-environment%>