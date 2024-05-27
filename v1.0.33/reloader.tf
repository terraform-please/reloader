resource "kubernetes_manifest" "serviceaccount_reloader_reloader" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "annotations" = {
        "meta.helm.sh/release-name" = "reloader"
        "meta.helm.sh/release-namespace" = "default"
      }
      "labels" = {
        "app" = "reloader-reloader"
        "app.kubernetes.io/managed-by" = "Helm"
        "chart" = "reloader-1.0.33"
        "heritage" = "Helm"
        "release" = "reloader"
      }
      "name" = "reloader-reloader"
      "namespace" = var.namespace
    }
  }
}

resource "kubernetes_manifest" "clusterrole_reloader_reloader_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "annotations" = {
        "meta.helm.sh/release-name" = "reloader"
        "meta.helm.sh/release-namespace" = "default"
      }
      "labels" = {
        "app" = "reloader-reloader"
        "app.kubernetes.io/managed-by" = "Helm"
        "chart" = "reloader-1.0.33"
        "heritage" = "Helm"
        "release" = "reloader"
      }
      "name" = "reloader-reloader-role"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
          "configmaps",
        ]
        "verbs" = [
          "list",
          "get",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "deployments",
          "daemonsets",
          "statefulsets",
        ]
        "verbs" = [
          "list",
          "get",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "extensions",
        ]
        "resources" = [
          "deployments",
          "daemonsets",
        ]
        "verbs" = [
          "list",
          "get",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_reloader_reloader_role_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "annotations" = {
        "meta.helm.sh/release-name" = "reloader"
        "meta.helm.sh/release-namespace" = "default"
      }
      "labels" = {
        "app" = "reloader-reloader"
        "app.kubernetes.io/managed-by" = "Helm"
        "chart" = "reloader-1.0.33"
        "heritage" = "Helm"
        "release" = "reloader"
      }
      "name" = "reloader-reloader-role-binding"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "reloader-reloader-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "reloader-reloader"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "deployment_reloader_reloader" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "annotations" = {
        "meta.helm.sh/release-name" = "reloader"
        "meta.helm.sh/release-namespace" = "default"
      }
      "labels" = {
        "app" = "reloader-reloader"
        "app.kubernetes.io/managed-by" = "Helm"
        "chart" = "reloader-1.0.33"
        "group" = "com.stakater.platform"
        "heritage" = "Helm"
        "provider" = "stakater"
        "release" = "reloader"
        "version" = "v1.0.33"
      }
      "name" = "reloader-reloader"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "revisionHistoryLimit" = 2
      "selector" = {
        "matchLabels" = {
          "app" = "reloader-reloader"
          "release" = "reloader"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "reloader-reloader"
            "app.kubernetes.io/managed-by" = "Helm"
            "chart" = "reloader-1.0.33"
            "group" = "com.stakater.platform"
            "heritage" = "Helm"
            "provider" = "stakater"
            "release" = "reloader"
            "version" = "v1.0.33"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "ghcr.io/stakater/reloader:v1.0.33"
              "imagePullPolicy" = "IfNotPresent"
              "livenessProbe" = {
                "failureThreshold" = 5
                "httpGet" = {
                  "path" = "/live"
                  "port" = "http"
                }
                "initialDelaySeconds" = 10
                "periodSeconds" = 10
                "successThreshold" = 1
                "timeoutSeconds" = 5
              }
              "name" = "reloader-reloader"
              "ports" = [
                {
                  "containerPort" = 9090
                  "name" = "http"
                },
              ]
              "readinessProbe" = {
                "failureThreshold" = 5
                "httpGet" = {
                  "path" = "/metrics"
                  "port" = "http"
                }
                "initialDelaySeconds" = 10
                "periodSeconds" = 10
                "successThreshold" = 1
                "timeoutSeconds" = 5
              }
              "securityContext" = {}
            },
          ]
          "securityContext" = {
            "runAsNonRoot" = true
            "runAsUser" = 65534
          }
          "serviceAccountName" = "reloader-reloader"
        }
      }
    }
  }
}
