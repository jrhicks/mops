---
to: ./Makefile
---

export AWS_PROFILE=<%= platform_name%>-<%= environment %>

help: # Print this help message
	@echo "Usage: \n"
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

cc: # Print Mops Copyright Info
	@echo 'MOPS (c) MIT 2023' # Makefile hack to make all recipes look un-built

aws-cli: cc # Install AWS CLI
	brew install awscli

hygen-cli: cc # Install Hygen - Code Generation Tool
	brew tap jondot/tap && \
	brew install hygen

kube-cli: cc # Install Kubernetes CLI
	brew install kubernetes-cli

flux-cli: cc # Install FluxCD CLI
	brew install fluxcd/tap/flux

config: cc # Generate Inial Configuration
	hygen mops config

mops: cc # Generate Mops Project Code
	hygen mops project

profile: cc # Configure AWS SSO Profile <%= platform_name%>-<%= environment %>
	aws configure sso --profile <%= platform_name%>-<%= environment %> \

profile-edit: cc # Edit AWS SSO Profiles
	code ~/.aws/config

login: cc # Authenticate CLIs using AWS Profile <%= platform_name%>-<%= environment %> and sets AWS_PROFILE ENV var to <%= platform_name%>-<%= environment %>
	aws sso login --profile <%= platform_name%>-<%= environment %>
	bash scripts/aws_profile_set.sh

cluster: cc # Setup & Terraform K8s Cluster, Configure GitOps, Load Balancer, Autoscaler, and Monioring
	make tf-backend && \
	make tf-init && \
	make tf-apply && \
	make kubectl-config && \
	say "Cluster Ready"

flux: cc # Bootstrap K8s cluster and Github repo with FluxCD GitOps abilities
	make kubectl-config && \
	bash scripts/flux_bootstrap.sh && \
	make fwatch && \
	say "Flux Ready"

tf-backend: cc # Create AWS Resources for Terraform Backend (S3, DynamoDB)
	bash scripts/terraform_backend_create.sh

tf-init: cc # Install Terraform Module Dependencies and Initialize Terraform Backend (S3, DynamoDB)
	cd terraform && \
	terraform init && \
	cd ..

tf-modules: cc # Install Terraform Module Dependencies
	cd terraform && \
	terraform init -backend=false && \
	cd ..

tf-apply: cc # Validate and Apply Terraform Scripts
	cd terraform && \
	terraform validate && \
	terraform apply && \
	cd ..

kubectl-config: cc # Configure Kubectl to point to EKS Cluster
	aws eks --region <%=aws_region%> update-kubeconfig --name <%=platform_name%>-<%= environment %>-cluster

fsync: cc # Trigger Flux to Reconcile 
	make kubectl-config && \
	flux reconcile source git flux-system && \
	make fwatch

fwatch: cc # Watch Flux reconcile
	make kubectl-config && \
    bash scripts/flux_watch.sh

ec2-tbl: cc # Print AWS Resource Table
	aws ec2 describe-instances \
		--filters "Name=instance-state-name,Values=running" \
		--query 'Reservations[*].Instances[*].[InstanceId, InstanceType]' \
		--output table \
		--region <%=aws_region%>

flogs: cc # Tail Flux Logs
	make kubectl-config && \
	flux logs --follow

alogs: cc # Tail cluster-autoscaler logs
	kubectl -n kube-system logs -f deployment/cluster-autoscaler-aws-cluster-autoscaler

plogs: cc # Prometheus Logs
	make kubectl-config && \
	kubectl logs deployment/kube-prometheus-stack-operator -n monitoring  && \
	kubectl logs prometheus-kube-prometheus-stack-prometheus-0 -n monitoring

pui: cc # Connect and open Prometheus UI
	make kubectl-config && \
	kubectl port-forward prometheus-kube-prometheus-stack-prometheus-0 -n monitoring 9090:9090 & \
	open http://localhost:9090

dashboard: cc # Connect and open Grafana Dashboard
	make kubectl-config && \
	kubectl -n monitoring port-forward svc/kube-prometheus-stack-grafana  3008:80 & \
	open http://localhost:3008

app: cc # Create continious deployment pipeline for an app.
	make kubectl-config && \
	hygen app create && \
	make tf-modules && \
	make tf-apply

# DANGER ZONE

flux-destroy: cc # Destroy CD pipeline and deployments
	make kubectl-config && \
	bash scripts/flux_destroy.sh

tf-destroy: cc # Destroy all the AWS resources
	cd terraform && \
	terraform destroy && \
	cd ..

tf-backend-destroy: cc # Destroy AWS Resources for Terraform Backend (S3, DynamoDB)
	bash scripts/terraform_backend_destroy.sh

project-destroy: cc # Destroy the scaffolded project
	rm -rf terraform && \
	rm -rf .env && \
	rm -rf scripts && \
	rm -rf cluster && \
	rm -rf k8s && \
	hygen mops end

push: cc # Push to Git
	git add . && \
	git commit -m "Commit all" && \
	git push

redo: cc # !! Overwrite project
	HYGEN_OVERWRITE=1 hygen mops project

go: cc # !! Push Repo & Trigger Gitop Reconcilation
	make push && \
	make fsync && \
	make fwatch
