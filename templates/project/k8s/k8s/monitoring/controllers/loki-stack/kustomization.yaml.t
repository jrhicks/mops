---
to: k8s/monitoring/controllers/loki-stack/kustomization.yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: monitoring
resources:
  - repository.yaml
  - release.yaml
