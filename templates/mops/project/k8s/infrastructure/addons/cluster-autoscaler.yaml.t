---
to: k8s/infrastructure/addons/cluster-autoscaler.yaml
---
---
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: cluster-autoscaler
  namespace: flux-system
spec:
  chart:
    spec:
      chart: cluster-autoscaler
      reconcileStrategy: ChartVersion
      sourceRef:
        kind: HelmRepository
        name: cluster-autoscaler
        namespace: flux-system
  install:
    crds: CreateReplace
  upgrade:
    crds: CreateReplace
  values:
    serviceMonitor:
      enabled: true
      interval: "10s" # Scrape interval
      namespace: "monitoring"
      path: "/metrics"
      selector:
        release: "kube-prometheus-stack"
    autoDiscovery:
      clusterName: <%=platform_name%>-cluster
    awsRegion: <%=aws_region%>
    cloudProvider: aws
    rbac:
      serviceAccount:
        create: false
        name: sa-cluster-autoscaler
    replicaCount: 2
  interval: 2m0s
  releaseName: cluster-autoscaler
  targetNamespace: kube-system