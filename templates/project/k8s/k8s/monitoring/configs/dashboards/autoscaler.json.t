---
to: k8s/monitoring/configs/dashboards/autoscaler.json
---
{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": {
          "type": "grafana",
          "uid": "-- Grafana --"
        },
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "description": "Super simple dashboard showing an overview of kubernetes cluster autoscaling activity and status, using metrics reported by the autoscaler to prometheus.\r\n\r\nhttps://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler",
  "editable": true,
  "fiscalYearStartMonth": 0,
  "gnetId": 3831,
  "graphTooltip": 0,
  "links": [],
  "liveNow": false,
  "panels": [
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 4,
        "w": 4,
        "x": 0,
        "y": 0
      },
      "id": 4,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "none",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "10.2.2",
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "disableTextWrap": false,
          "editorMode": "builder",
          "expr": "sum(cluster_autoscaler_nodes_count{state=\"ready\"})",
          "format": "time_series",
          "fullMetaSearch": false,
          "includeNullMetadata": true,
          "intervalFactor": 2,
          "range": true,
          "refId": "A",
          "step": 600,
          "useBackend": false
        }
      ],
      "title": "Ready nodes",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${DS_PROMETHEUS}"
      },
      "description": "Shows the nodes which are ready as a percent of the total nodes",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "max": 100,
          "min": 0,
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "red",
                "value": null
              },
              {
                "color": "yellow",
                "value": 94.9996
              },
              {
                "color": "green",
                "value": 99.9999
              }
            ]
          },
          "unit": "percent"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 4,
        "w": 4,
        "x": 4,
        "y": 0
      },
      "id": 6,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "minVizHeight": 75,
        "minVizWidth": 75,
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "showThresholdLabels": false,
        "showThresholdMarkers": false
      },
      "pluginVersion": "10.2.2",
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_nodes_count{state=\"ready\"})/sum(cluster_autoscaler_nodes_count)*100",
          "format": "time_series",
          "intervalFactor": 2,
          "refId": "A",
          "step": 600
        }
      ],
      "title": "Nodes available",
      "type": "gauge"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [
            {
              "options": {
                "0": {
                  "text": "No"
                },
                "1": {
                  "text": "Yes"
                }
              },
              "type": "value"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "rgba(245, 54, 54, 0.9)",
                "value": null
              },
              {
                "color": "rgba(237, 129, 40, 0.89)",
                "value": 0
              },
              {
                "color": "rgba(50, 172, 45, 0.97)",
                "value": 1
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 4,
        "w": 4,
        "x": 8,
        "y": 0
      },
      "id": 9,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "background",
        "graphMode": "none",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "10.2.2",
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "editorMode": "code",
          "expr": "max(cluster_autoscaler_cluster_safe_to_autoscale)",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "{{label_name}}",
          "range": true,
          "refId": "A",
          "step": 600
        }
      ],
      "title": "Is cluster safe to scale?",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${DS_PROMETHEUS}"
      },
      "description": "Tells you if there are unscheduled pods",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "rgba(50, 172, 45, 0.97)",
                "value": null
              },
              {
                "color": "rgba(237, 129, 40, 0.89)",
                "value": 1
              },
              {
                "color": "rgba(245, 54, 54, 0.9)"
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 4,
        "w": 4,
        "x": 12,
        "y": 0
      },
      "id": 12,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "background",
        "graphMode": "none",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "10.2.2",
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_unschedulable_pods_count)",
          "format": "time_series",
          "intervalFactor": 1,
          "legendFormat": " pods",
          "refId": "A",
          "step": 300
        }
      ],
      "title": "Number of unscheduled pods",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "s"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 4,
        "w": 4,
        "x": 16,
        "y": 0
      },
      "id": 7,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "none",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "10.2.2",
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(time()-cluster_autoscaler_last_activity{activity=\"scaleDown\"})",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "",
          "refId": "A",
          "step": 600
        }
      ],
      "title": "Last scaleDown activity",
      "type": "stat"
    },
    {
      "datasource": {
        "uid": "${DS_PROMETHEUS}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [
            {
              "options": {
                "match": "null",
                "result": {
                  "text": "N/A"
                }
              },
              "type": "special"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "s"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 4,
        "w": 4,
        "x": 20,
        "y": 0
      },
      "id": 8,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "none",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "10.2.2",
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(time()-cluster_autoscaler_last_activity{activity=\"autoscaling\"})",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "",
          "refId": "A",
          "step": 600
        }
      ],
      "title": "Last autoscale activity",
      "type": "stat"
    },
    {
      "alerting": {},
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "uid": "${DS_PROMETHEUS}"
      },
      "description": "Shows the evicted and unscheduled pods",
      "editable": true,
      "error": false,
      "fill": 1,
      "fillGradient": 0,
      "grid": {},
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 4
      },
      "height": "250px",
      "hiddenSeries": false,
      "id": 11,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 2,
      "links": [],
      "nullPointMode": "null as zero",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "10.2.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_evicted_pods_total)",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 10,
          "legendFormat": "evicted pods",
          "metric": "",
          "refId": "A",
          "step": 300
        },
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_unschedulable_pods_count)",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "unscheduled pods",
          "refId": "B",
          "step": 60
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Pod activity",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "cumulative"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "none",
          "label": "Num Nodes",
          "logBase": 1,
          "min": 0,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "alerting": {},
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "uid": "${DS_PROMETHEUS}"
      },
      "description": "Shows the state of the nodes as scaling happens",
      "editable": true,
      "error": false,
      "fill": 1,
      "fillGradient": 0,
      "grid": {},
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 4
      },
      "height": "250px",
      "hiddenSeries": false,
      "id": 10,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 2,
      "links": [],
      "nullPointMode": "null as zero",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "10.2.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_nodes_count{state=\"ready\"})",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 10,
          "legendFormat": "ready",
          "metric": "",
          "refId": "A",
          "step": 300
        },
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_nodes_count{state=\"unready\"})",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "unready",
          "refId": "B",
          "step": 60
        },
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_nodes_count{state=\"notStarted\"})\n",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "not started",
          "refId": "C",
          "step": 60
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Node activity",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "cumulative"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "none",
          "label": "Num Nodes",
          "logBase": 1,
          "min": 0,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "alerting": {},
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "uid": "${DS_PROMETHEUS}"
      },
      "editable": true,
      "error": false,
      "fill": 1,
      "fillGradient": 0,
      "grid": {},
      "gridPos": {
        "h": 7,
        "w": 16,
        "x": 0,
        "y": 11
      },
      "height": "250px",
      "hiddenSeries": false,
      "id": 3,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 2,
      "links": [],
      "nullPointMode": "connected",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "10.2.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_scaled_up_nodes_total)",
          "format": "time_series",
          "hide": false,
          "intervalFactor": 10,
          "legendFormat": "scaled up total",
          "metric": "",
          "refId": "A",
          "step": 200
        },
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_unneeded_nodes_count)",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "unneeded nodes",
          "refId": "B",
          "step": 40
        },
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_nodes_count)\n",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "total nodes",
          "refId": "C",
          "step": 40
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "Autoscaling activity",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "cumulative"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "none",
          "label": "Num nodes",
          "logBase": 1,
          "min": 0,
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    },
    {
      "datasource": {
        "uid": "${DS_PROMETHEUS}"
      },
      "description": "Is the cluster scaling up, down or ticking along okay?",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [
            {
              "options": {
                "from": -1000,
                "result": {
                  "text": "Down"
                },
                "to": -1
              },
              "type": "range"
            },
            {
              "options": {
                "from": 1,
                "result": {
                  "text": "Up"
                },
                "to": 1000
              },
              "type": "range"
            },
            {
              "options": {
                "from": 0,
                "result": {
                  "text": "Nowhere"
                },
                "to": 0
              },
              "type": "range"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 4,
        "w": 8,
        "x": 16,
        "y": 11
      },
      "id": 13,
      "links": [],
      "maxDataPoints": 100,
      "options": {
        "colorMode": "none",
        "graphMode": "none",
        "justifyMode": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "10.2.2",
      "targets": [
        {
          "datasource": {
            "uid": "${DS_PROMETHEUS}"
          },
          "expr": "sum(cluster_autoscaler_scaled_up_nodes_total)-sum(cluster_autoscaler_scaled_down_nodes_total)",
          "format": "time_series",
          "intervalFactor": 2,
          "legendFormat": "",
          "refId": "A",
          "step": 600
        }
      ],
      "title": "Cluster direction?",
      "type": "stat"
    }
  ],
  "refresh": "",
  "schemaVersion": 38,
  "tags": [
    "prometheus"
  ],
  "templating": {
    "list": [
      {
        "current": {
          "selected": false,
          "text": "Prometheus",
          "value": "prometheus"
        },
        "hide": 0,
        "includeAll": false,
        "label": "Datasource",
        "multi": false,
        "name": "DS_PROMETHEUS",
        "options": [],
        "query": "prometheus",
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "type": "datasource"
      }
    ]
  },
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {
    "refresh_intervals": [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d"
    ],
    "time_options": [
      "5m",
      "15m",
      "1h",
      "6h",
      "12h",
      "24h",
      "2d",
      "7d",
      "30d"
    ]
  },
  "timezone": "browser",
  "title": "Kubernetes Cluster Autoscaler (via Prometheus)",
  "uid": "bb0169c8-f2cd-46e7-8524-97342820b9ce",
  "version": 1,
  "weekStart": ""
}