---
to: scripts/terraform_backend_create.sh
---
aws s3api create-bucket \
    --bucket <%=platform_name%>-<%-environment%>-terraform-be \
    --region <%=aws_region%> \
    --profile <%=platform_name%>-<%-environment%>

aws dynamodb create-table \
    --table-name <%=platform_name%>-<%-environment%>-terraform-be \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region <%=aws_region%> \
    --profile <%=platform_name%>-<%-environment%>