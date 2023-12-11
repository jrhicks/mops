---
to: ./Makefile
---

export AWS_PROFILE=<%= platform_name%>-<%= environment %>

help: # Print this help message
	@echo "Usage: \n"
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

aws-cli: # Install AWS CLI
	brew install awscli

hygen-cli: # Install Hygen - Code Generation Tool
	brew tap jondot/tap && \
	brew install hygen

kube-cli: # Install Kubernetes CLI
	brew install kubernetes-cli

flux-cli: # Install FluxCD CLI
	brew install fluxcd/tap/flux

mops-config: # Generate Inial Configuration
	hygen mops config

mops-project: # Generate Mops Project Code
	hygen mops project

profile: # Configure AWS SSO Profile <%= platform_name%>-<%= environment %>
	aws configure sso --profile <%= platform_name%>-<%= environment %> \

profile-edit: # Edit AWS SSO Profiles
	code ~/.aws/config

login: # Authenticate CLIs using AWS Profile <%= platform_name%>-<%= environment %> and sets AWS_PROFILE ENV var to <%= platform_name%>-<%= environment %>
	aws sso login --profile <%= platform_name%>-<%= environment %>
	bash scripts/aws_profile_set.sh

cluster: # Setup & Terraform K8s Cluster, Configure GitOps, Load Balancer, Autoscaler, and Monioring
	make tf-backend && \ 
	make tf-init && \
	make tf-apply && \
	make kubectl-config && \
	say "Cluster Ready"

bootstrap: # Bootstrap K8s cluster and Github repo with FluxCD GitOps abilities
	make kubectl-config && \
	bash scripts/flux_bootstrap.sh && \
	make fwatch && \	
	say "GitOps Ready"

tf-backend: # Create AWS Resources for Terraform Backend (S3, DynamoDB)
	bash scripts/terraform_backend_create.sh

tf-init: # Install Terraform Module Dependencies and Initialize Terraform Backend (S3, DynamoDB)
	echo ${AWS_PROFILE} && \
	cd terraform && \
	terraform init && \
	cd ..

tf-modules: # Install Terraform Module Dependencies
	cd terraform && \
	terraform init -backend=false && \
	cd ..

tf-apply: # Validate and Apply Terraform Scripts
	cd terraform && \
	terraform validate && \
	terraform apply && \
	cd ..

kubectl-config: # Configure Kubectl to point to EKS Cluster
	aws eks --region <%=aws_region%> update-kubeconfig --name <%=platform_name%>-<%= environment %>-cluster


fsync: # Trigger Flux to Reconcile 
	make kubectl-config && \
	flux reconcile source git flux-system && \
	make fwatch

fwatch: # Watch Flux reconcile
	make kubectl-config && \
    bash scripts/flux_watch.sh

ec2-tbl: # Print AWS Resource Table
	aws ec2 describe-instances \
		--filters "Name=instance-state-name,Values=running" \
		--query 'Reservations[*].Instances[*].[InstanceId, InstanceType]' \
		--output table \
		--region <%=aws_region%>

flogs: # Tail Flux Logs
	make kubectl-config && \
	flux logs --follow

alogs: # Tail cluster-autoscaler logs
	kubectl -n kube-system logs -f deployment/cluster-autoscaler-aws-cluster-autoscaler

plogs: # Prometheus Logs
	make kubectl-config && \
	kubectl logs deployment/kube-prometheus-stack-operator -n monitoring  && \
	kubectl logs prometheus-kube-prometheus-stack-prometheus-0 -n monitoring

pui: # Connect and open Prometheus UI
	make kubectl-config && \
	kubectl port-forward prometheus-kube-prometheus-stack-prometheus-0 -n monitoring 9090:9090 & \
	open http://localhost:9090

dashboard: # Connect and open Grafana Dashboard
	make kubectl-config && \
	kubectl -n monitoring port-forward svc/kube-prometheus-stack-grafana  3008:80 & \
	open http://localhost:3008

app: # Create continious deployment pipeline for an app.
	make kubectl-config && \	
	hygen app pipeline && \
	make tf-modules && \
	make tf-apply

# DANGER ZONE

flux-destroy: # Destroy CD pipeline and deployments
	make kubectl-config && \
	bash scripts/flux_destroy.sh

tf-destroy: # Destroy all the AWS resources
	cd terraform && \
	terraform destroy && \
	cd ..

tf-backend-destroy: # Destroy AWS Resources for Terraform Backend (S3, DynamoDB)
	bash scripts/terraform_backend_destroy.sh

project-destroy: # Destroy the scaffolded project
	rm -rf terraform && \
	rm -rf .env && \
	rm -rf scripts && \
	rm -rf cluster && \
	rm -rf k8s && \
	hygen project end

push: # Push to Git
	git add . && \
	git commit -m "Commit all" && \
	git push

redo: # !! Overwrite project
	HYGEN_OVERWRITE=1 hygen project env

go: # !! Push Repo & Trigger Gitop Reconcilation
	make push && \
	make fsync && \
	make fwatch
