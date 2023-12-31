---
to: k8s/monitoring/controllers/kube-prometheus-stack/kube-state-metrics-config.yaml
---
kube-state-metrics:
  # For kube-prometheus-stacks that are already installed and configured with
  # custom collectors, commenting out the collectors and extraArgs below will
  # retain any existing kube-state-metrics configuration.
  # collectors: [ ] # Uncomment to disable all collectors
  extraArgs:
    - --custom-resource-state-only=fase
  rbac:
    extraRules:
      - apiGroups:
          - source.toolkit.fluxcd.io
          - kustomize.toolkit.fluxcd.io
          - helm.toolkit.fluxcd.io
          - notification.toolkit.fluxcd.io
          - image.toolkit.fluxcd.io
        resources:
          - gitrepositories
          - buckets
          - helmrepositories
          - helmcharts
          - ocirepositories
          - kustomizations
          - helmreleases
          - alerts
          - providers
          - receivers
          - imagerepositories
          - imagepolicies
          - imageupdateautomations
        verbs: [ "list", "watch" ]
  customResourceState:
    enabled: true
    config:
      spec:
        resources:
          - groupVersionKind:
              group: kustomize.toolkit.fluxcd.io
              version: v1
              kind: Kustomization
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  revision: [ status, lastAppliedRevision ]
                  source_name: [ spec, sourceRef, name ]
          - groupVersionKind:
              group: helm.toolkit.fluxcd.io
              version: v2beta1
              kind: HelmRelease
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  revision: [ status, lastAppliedRevision ]
                  chart_name: [ spec, chart, spec, chart ]
                  chart_source_name: [ spec, chart, spec, sourceRef, name ]
          - groupVersionKind:
              group: source.toolkit.fluxcd.io
              version: v1
              kind: GitRepository
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  revision: [ status, artifact, revision ]
                  url: [ spec, url ]
          - groupVersionKind:
              group: source.toolkit.fluxcd.io
              version: v1beta2
              kind: Bucket
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  revision: [ status, artifact, revision ]
                  endpoint: [ spec, endpoint ]
                  bucket_name: [ spec, bucketName ]
          - groupVersionKind:
              group: source.toolkit.fluxcd.io
              version: v1beta2
              kind: HelmRepository
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  revision: [ status, artifact, revision ]
                  url: [ spec, url ]
          - groupVersionKind:
              group: source.toolkit.fluxcd.io
              version: v1beta2
              kind: HelmChart
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  revision: [ status, artifact, revision ]
                  chart_name: [ spec, chart ]
                  chart_version: [ spec, version ]
          - groupVersionKind:
              group: source.toolkit.fluxcd.io
              version: v1beta2
              kind: OCIRepository
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  revision: [ status, artifact, revision ]
                  url: [ spec, url ]
          - groupVersionKind:
              group: notification.toolkit.fluxcd.io
              version: v1beta2
              kind: Alert
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
          - groupVersionKind:
              group: notification.toolkit.fluxcd.io
              version: v1beta2
              kind: Provider
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
          - groupVersionKind:
              group: notification.toolkit.fluxcd.io
              version: v1
              kind: Receiver
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  webhook_path: [ status, webhookPath ]
          - groupVersionKind:
              group: image.toolkit.fluxcd.io
              version: v1beta2
              kind: ImageRepository
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  image: [ spec, image ]
          - groupVersionKind:
              group: image.toolkit.fluxcd.io
              version: v1beta2
              kind: ImagePolicy
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  source_name: [ spec, imageRepositoryRef, name ]
          - groupVersionKind:
              group: image.toolkit.fluxcd.io
              version: v1beta1
              kind: ImageUpdateAutomation
            metricNamePrefix: gotk
            metrics:
              - name: "resource_info"
                help: "The current state of a GitOps Toolkit resource."
                each:
                  type: Info
                  info:
                    labelsFromPath:
                      name: [ metadata, name ]
                labelsFromPath:
                  exported_namespace: [ metadata, namespace ]
                  ready: [ status, conditions, "[type=Ready]", status ]
                  suspended: [ spec, suspend ]
                  source_name: [ spec, sourceRef, name ]
