---
to: ./k8s/infrastructure/sources/external-dns.yaml
---
---
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: external-dns
  namespace: flux-system
spec:
  interval: 5m0s
  url: https://kubernetes-sigs.github.io/external-dns