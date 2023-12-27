export AWS_PROFILE=ppd-compute

help: # Print this help message
	@echo "Usage: \n"
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

cc: # Print Mops Copyright Info
	@echo 'MOPS (c) MIT 2023' # Makefile hack to make all recipes look un-built

aws-cli: cc # Install AWS CLI
	brew install awscli

aws-profile: cc # Configure AWS SSO Profile ppd-compute
	aws configure sso --profile ppd-compute \

aws-profile-edit: cc # Edit AWS SSO Profiles
	code ~/.aws/config

aws-login: cc # Authenticate CLIs using AWS Profile ppd-compute and sets AWS_PROFILE ENV var to ppd-compute
	aws sso login --profile ppd-compute

aws-nameservers: cc # List name servers for Route53 hosted zone (after Terraform)
	aws route53 get-hosted-zone --id $$(cd terraform; terraform output -raw hosted_zone_id) --profile ppd-compute

tf-cli: cc # Install Terraform CLI
	brew install terraform

tf-iac: cc # Scaffold Project's Terraform Code 
	hygen project terraform

tf-init: cc # Create AWS Resources for Terraform Backend and initialize client
	bash scripts/terraform_backend_create.sh && \
	cd terraform && \
	terraform init && \

tf-apply: cc # Validate and Apply Terraform Scripts
	cd terraform && \
	terraform apply && \
	cd ..

k8s-cli: cc # Install Kubernetes CLI
	brew install kubectl

k8s-login: cc # Configure Kubectl to point to EKS Cluster
	aws eks --region us-east-1 update-kubeconfig --name ppd-compute-cluster

k8s-iac: cc # Scaffold Project's K8s Code 
	hygen project k8s

flux-cli: cc # Install FluxCD CLI
	brew install fluxcd/tap/flux

flux-bootstrap: cc # Bootstrap K8s cluster and Github repo with FluxCD GitOps abilities
	make k8s-login && \
	bash scripts/flux_bootstrap.sh && \
	make flux-watch

flux-ecr-credentials: cc # Update ECR Credentials for FluxCD image-repository scanning
	bash scripts/ecr_credentials_renew.sh

flux-gh-deploy-keys: cc # Enable FluxCD image-update-automation
	echo "Add the key to Github Deploy Keys: " && \
	flux create secret git -n flux-system flux-system --url=ssh://git@github.com/PinpointDining/ppd-compute

flux-sync: cc # Trigger Flux to Reconcile 
	make k8s-login && \
	flux reconcile source git flux-system && \
	make flux-watch

flux-watch: cc # Watch Flux reconcile
	make k8s-login && \
    bash scripts/flux_watch.sh && \
	say "Flux Ready"

app-iac: cc # Scaffold an App
	hygen app all

app-rds-password: cc # Generate random username and password for RDS
	@echo "username: $$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z' | fold -w 16 | head -n 1)" && \
	echo "password: $$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z1-9' | fold -w 32 | head -n 1)"

# APP COMMANDS
# booking-production

booking-production-s3-key: cc # Create Access Keys for booking-production (to add to Github Secrets)
	aws iam create-access-key --user-name ppd-compute-booking-production-bucket-user --profile ppd-compute

booking-production-s3-key-delete: cc # List AWS Access Keys (usefull for deleting)
	aws iam list-access-keys --user-name ppd-compute-booking-production-bucket-user --profile ppd-compute && \
	echo "TO DELETE: aws iam delete-access-key --user-name "ppd-compute-booking-production-bucket-user" --profile ppd-compute" --access-key-id "REPLACE-ME"

booking-production-sync: cc # Trigger FLuxCD to Reconcile booking-production
	flux reconcile kustomization booking-production-kustomization

booking-production-rails-master-key-secret: cc # Deploy K8s SECRET rails_master_key for booking
	read -p "rails_master_key (production): " rails_master_key && \
	kubectl create secret generic booking-production-rails-master-key --from-literal=RAILS_MASTER_KEY=$$rails_master_key --namespace=booking-production-ns

# booking

booking-gh-key: cc # Create Access Keys for booking (to add to Github Secrets)
	aws iam create-access-key --user-name booking-repo-gh-user --profile ppd-compute

booking-gh-key-delete: cc # List AWS Access Keys (usefull for deleting)
	aws iam list-access-keys --user-name ppd-compute-booking-production-bucket-user --profile ppd-compute && \
	echo "TO DELETE: aws iam delete-access-key --user-name "booking-repo-gh-user" --profile ppd-compute" --access-key-id "REPLACE-ME"



# DANGER ZONE

flux-destroy: cc # Destroy CD pipeline and deployments
	make k8s-login && \
	bash scripts/flux_destroy.sh

tf-destroy: cc # Destroy all the AWS resources
	cd terraform && \
	terraform destroy && \
	cd ..

tf-force-unlock: cc # Force Unlock Terraform State
	read -p "LOCK ID: " LOCK_ID && \
	cd terraform;  terraform force-unlock -force $$LOCK_ID; cd ..

tf-backend-destroy: cc # Destroy AWS Resources for Terraform Backend (S3, DynamoDB)
	bash scripts/terraform_backend_destroy.sh

project-destroy: cc # Destroy the scaffolded project
	rm -rf terraform && \
	rm -rf scripts && \
	rm -rf cluster && \
	rm -rf k8s && \
	rm nuke-config.yml \
	hygen project end

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

# ULTRA DANGER ZONE

nuke-cli: cc # Install aws-nuke CLI
	brew install aws-nuke

nuke-aws-account: cc # !! Nuke AWS Account
	aws-nuke -c nuke-config.yml --profile ppd-compute --no-dry-run