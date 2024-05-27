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
        "app.kubernetes.io/managed-by" = "Tiller"
        "chart" = "reloader-v0.0.74"
        "heritage" = "Tiller"
        "release" = "reloader"
      }
      "name" = "reloader-reloader-role"
      "namespace" = var.namespace
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
        "app.kubernetes.io/managed-by" = "Tiller"
        "chart" = "reloader-v0.0.74"
        "heritage" = "Tiller"
        "release" = "reloader"
      }
      "name" = "reloader-reloader-role-binding"
      "namespace" = var.namespace
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
        "app.kubernetes.io/managed-by" = "Tiller"
        "chart" = "reloader-v0.0.74"
        "group" = "com.stakater.platform"
        "heritage" = "Tiller"
        "provider" = "stakater"
        "release" = "reloader"
        "version" = "v0.0.74"
      }
      "name" = "reloader-reloader"
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
            "app.kubernetes.io/managed-by" = "Tiller"
            "chart" = "reloader-v0.0.74"
            "group" = "com.stakater.platform"
            "heritage" = "Tiller"
            "provider" = "stakater"
            "release" = "reloader"
            "version" = "v0.0.74"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "stakater/reloader:v0.0.74"
              "imagePullPolicy" = "IfNotPresent"
              "livenessProbe" = {
                "httpGet" = {
                  "path" = "/metrics"
                  "port" = "http"
                }
              }
              "name" = "reloader-reloader"
              "ports" = [
                {
                  "containerPort" = 9090
                  "name" = "http"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/metrics"
                  "port" = "http"
                }
              }
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
        "app.kubernetes.io/managed-by" = "Tiller"
        "chart" = "reloader-v0.0.74"
        "heritage" = "Tiller"
        "release" = "reloader"
      }
      "name" = "reloader-reloader"
    }
  }
}
