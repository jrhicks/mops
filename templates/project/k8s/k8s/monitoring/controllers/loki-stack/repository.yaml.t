---
to: k8s/monitoring/controllers/loki-stack/repository.yaml
---
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: grafana-charts
spec:
  interval: 120m0s
  url: https://grafana.github.io/helm-charts
