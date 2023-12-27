---
to: scripts/terraform_backend_create.sh
---
aws s3api create-bucket \
    --bucket <%=platform_name%>-terraform-be \
    --region <%=aws_region%> \
    --profile <%=platform_name%>

aws dynamodb create-table \
    --table-name <%=platform_name%>-terraform-be \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region <%=aws_region%> \
    --profile <%=platform_name%>

while true; do
    status=$(aws dynamodb describe-table --table-name <%=platform_name%>-terraform-be --region <%=aws_region%> --profile <%=platform_name%> --query 'Table.TableStatus' --output text)
    if [[ "$status" == "ACTIVE" ]]; then
        echo "Table is active"
        break
    else
        echo "Table is $status, waiting..."
        sleep 3
    fi
done