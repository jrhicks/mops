---
to: k8s/monitoring/controllers/kube-prometheus-stack/release.yaml
---
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: kube-prometheus-stack
spec:
  interval: 1h
  chart:
    spec:
      version: "55.x"
      chart: kube-prometheus-stack
      sourceRef:
        kind: HelmRepository
        name: prometheus-community
      interval: 1h
  install:
    crds: Create
  upgrade:
    crds: CreateReplace
  valuesFrom:
  - kind: ConfigMap
    name: flux-kube-state-metrics-config
    valuesKey: kube-state-metrics-config.yaml
  # https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml
  values:
    alertmanager:
      enabled: false
    prometheus:
      prometheusSpec:
        retention: 24h
        resources:
          requests:
            cpu: 200m
            memory: 200Mi
        podMonitorNamespaceSelector: { }
        podMonitorSelector:
          matchLabels:
            app.kubernetes.io/component: monitoring
    grafana:
      defaultDashboardsEnabled: false
      adminPassword: flux
  postRenderers:
    - kustomize:
        patches:
          - target:
              # Ignore these objects from Flux diff as they are mutated from chart hooks
              kind: (ValidatingWebhookConfiguration|MutatingWebhookConfiguration)
              name: kube-prometheus-stack-admission
            patch: |
              - op: add
                path: /metadata/annotations/helm.toolkit.fluxcd.io~1driftDetection
                value: disabled
          - target:
              # Ignore these objects from Flux diff as they are mutated at apply time but not at dry-run time
              kind: PrometheusRule
            patch: |
              - op: add
                path: /metadata/annotations/helm.toolkit.fluxcd.io~1driftDetection
                value: disabled
