---
to: k8s/monitoring/controllers/kube-prometheus-stack/kustomizeconfig.yaml
---
nameReference:
- kind: ConfigMap
  version: v1
  fieldSpecs:
  - path: spec/valuesFrom/name
    kind: HelmRelease
