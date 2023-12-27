---
to: scripts/flux_destroy.sh
---
flux suspend kustomization apps-addons apps-namespaces apps-sources	
flux delete helmrelease -s weave-gitops
flux delete kustomization -s apps-addons
flux delete kustomization -s apps-namespaces
flux delete kustomization -s apps-sources
flux delete source helm -s weave-gitops
flux delete kustomization -s monitoring-configs

kubectl -n flux-system get all -l app.kubernetes.io/name=weave-gitops
kubectl -n flux-system get ingresses -l app.kubernetes.io/name=weave-gitops

flux suspend kustomization infra-addons infra-configs infra-sources
flux delete helmrelease -s metrics-server
flux delete helmrelease -s external-dns
flux delete helmrelease -s aws-load-balancer-controller
flux delete helmrelease -s cluster-autoscaler
flux delete source helm -s metrics-server
flux delete source helm -s external-dns
flux delete source helm -s eks-charts
flux delete source helm -s cluster-autoscaler

kubectl -n kube-system get all -l app.kubernetes.io/name=external-dns
kubectl -n kube-system get all -l app.kubernetes.io/name=aws-load-balancer-controller
kubectl -n kube-system get all -l app.kubernetes.io/name=aws-cluster-autoscaler
kubectl get ingressclasses -l app.kubernetes.io/name=aws-load-balancer-controller	

flux uninstall -s

kubectl get ns flux-system
