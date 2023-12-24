---
to: k8s/monitoring/controllers/kube-prometheus-stack/namespace.yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
  labels:
    app.kubernetes.io/component: monitoring
