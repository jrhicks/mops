---
to: k8s/infrastructure/sources/eks-charts.yaml
---
---
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: eks-charts
  namespace: flux-system
spec:
  interval: 5m0s
  url: https://aws.github.io/eks-charts