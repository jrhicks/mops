---
to: k8s/monitoring/configs/kustomization.yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: monitoring
resources:
  - alb-monitor.yaml
  - flux-monitor.yaml
configMapGenerator:
  - name: flux-grafana-dashboards
    files:
      - dashboards/control-plane.json
      - dashboards/cluster.json
      - dashboards/logs.json
      - dashboards/autoscaler.json
    options:
      labels:
        grafana_dashboard: "1"
        app.kubernetes.io/part-of: flux
        app.kubernetes.io/component: monitoring
