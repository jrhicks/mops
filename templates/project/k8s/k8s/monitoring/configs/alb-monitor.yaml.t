---
to: k8s/monitoring/configs/alb-monitor.yaml
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: alb-monitor
  namespace: monitoring
  labels:
    release: kube-prometheus-stack
    app.kubernetes.io/part-of: flux
    app.kubernetes.io/component: monitoring
spec:
  endpoints:
  - targetPort: 8080
    interval: 30s
  namespaceSelector:
    matchNames:
      - kube-system      
  selector:
    matchLabels:
      app.kubernetes.io/name: aws-load-balancer-controller
