---
to: ./scripts/ecr_credentials_renew.sh 
---
kubectl delete secret ecr-credentials -n flux-system || true
kubectl create secret docker-registry ecr-credentials \
  --docker-server=<%=aws_account_id%>.dkr.ecr.<%=aws_region%>.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region <%=aws_region%> --profile <%=platform_name%>) \
  --namespace=flux-system
