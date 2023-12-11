# make-ops

Make recipes for platform generation and operation.

## TAEFP Stack

* **T**erraform (IaC)
* **A**WS (Cloud)
* **E**KS (Kubernetes)
* **F**luxCD w/ Github (GitOps)
* **P**rometheus w/ Grafana (Monitoring)

## Opinions

* 2-Factor authentication for Terraform
* 1 AWS account per platform environment
* 1 Github repo per platform environment
* App repo(s) separate from platform repo

## CLI Dependencies

```bash
make aws-cli # Install AWS CLI
make k8s-cli # Install Kubernetes CLI
make hygen-cli # Installs code generator CLI
make flux-cli # Installs FluxCD CLI
```

## Account Dependencies

* Create AWS Member Account (e.g. my-company-staging), create Identity Center User, take note of the AWS Account ID and SSO Start URL

* Create Github Repository, (e.g. my-company-staging-platform), create a Personal Access Token

## Getting Started

```bash
make config   # 1) Initialize configs
code .mops.js # 2) Edit the config file
make profile  # 3) Create AWS SSO Profile
make login    # 4) Login to AWS SSO Profile
```

## Zero to K8s Cluster

```bash
make cluster
```

## From Cluster to GitOps

```bash
make bootstrap
```

## Monitoring

```bash
make dashboard
```

## References

* [AWS Account](https://docs.aws.amazon.com/accounts/latest/reference/accounts-welcome.html) - A basic container for AWS resources and security boundary.
* [Identity Center User](https://aws.amazon.com/iam/identity-center) - Short-lived authentication.  No distributing access keys and associated risk of exposed secrets.  Forced 2FA for CLI Access.
* [S3 Bucket](https://aws.amazon.com/s3/) for [Terraform State](https://developer.hashicorp.com/terraform/language/state) - Terraform must store state about managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, and keep track of metadata
* [Dynamo DB](https://aws.amazon.com/dynamodb/) for [Terraform State Locking](https://developer.hashicorp.com/terraform/language/state/locking) - Ensures that only one operation (like apply or plan) that could write or change the state is performed at a time.  Price likely not a concern given DynamoDB's Utility Pricing model and the low volume of transactions.
* [Route53 Zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zones-working-with.html) - Controls how to Route traffic for a specific domain, and subdomains.

### Github Resources

* [Repository](https://fluxcd.io/flux/guides/repository-structure/) - The Source of Truth for your Infrastructure.  FluxCD will monitor this repo (and the repos it references) for changes and applies them to your cluster.
* [Flux User for Github Organization](https://fluxcd.io/flux/installation/bootstrap/github/#github-organization) - When performing GitOps using a Organization Owned Repo, Flux recommends you create a dedicated user.
* [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) - Flux requires Github Authentication Secrets since it acts on your repo during the bootstrap process.

### Terraformed AWS Resources

* ACM - [Amazon Certficate Manager](https://aws.amazon.com/certificate-manager/) - Provision and manage SSL/TLS certificates with AWS services and connected resources
* VPC - [Amazon Virtual Private Cloud](https://aws.amazon.com/vpc/) - Define and launch AWS resources in a logically isolated virtual network
* EKS - [Amazon Elastic Kubernetes Service](https://aws.amazon.com/eks/?nc2=type_a) - The most trusted way to start, run, and scale Kubernetes
* ECR - [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/) - Easily store, share, and deploy your container software anywhere
* EKS Roles - [IAM Roles for Service Accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html) - Allow K8s pods to assume specific AWS IAM roles, enabling fine-grained permission control for applications, such as an K8s Autoscaler, without embedding AWS credentials within them.

### Initial GitOps Resources

* [GitRepository](https://fluxcd.io/flux/components/source/gitrepositories/) (A Continious Delivery Source)
* [Kustomization](https://fluxcd.io/flux/components/kustomize/) (A Continious Delivery Pipeline)

### GitOps Controlled K8s Addons & Configs
 
 * [Load Balance Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.6/)
 * [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler) - Cluster Autoscaler - a component that automatically adjusts the size of a Kubernetes Cluster so that all pods have a place to run and there are no unneeded nodes.  `Requires Kubernetes v1.3.0 or greater`
 * [External DNS](https://kubernetes-sigs.github.io/external-dns/v0.14.0/) - External DNS - a Kubernetes addon that configures public DNS servers with information about exposed Kubernetes Services to make them discoverable. 
 * [Metrics Server](https://kubernetes-sigs.github.io/metrics-server/) - Metrics Server is a scalable, efficient source of container resource metrics for Kubernetes built-in autoscaling pipelines.

### GitOps Controlled K8s Apps

* [Weave-Gitops](https://docs.gitops.weave.works/) - GitOps UI for FluxCD

* [Kube-Prometheus-Stack](https://github.com/fluxcd/flux2-monitoring-example) - A collection of Kubernetes manifests, Grafana dashboards, Prometheus rules, and Grafana data sources and dashboards to operate Kubernetes clusters using Prometheus Operator and Grafana.  `Requires Kubernetes v1.16.0 or greater`


## MIT LICENSE

Copyright 2023 Jeffrey R. Hicks

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.