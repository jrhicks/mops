---
to: k8s/infrastructure/sources/kustomization.yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: flux-system
resources:
  - eks-charts.yaml
  - cluster-autoscaler.yaml
  - external-dns.yaml
  - metrics-server.yaml
 
