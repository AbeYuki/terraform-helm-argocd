terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.27.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/minikube"
    config_context = "minikube"
  }
}
provider "kubernetes" {
  config_path    = "~/.kube/minikube"
  config_context = "minikube"
}
provider "kubectl" {
  config_path    = "~/.kube/minikube"
  config_context = "minikube"
}

module "common" {
  source = "../modules/common"
}

resource "kubectl_manifest" "app_of_apps" {
    yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app-of-apps-root
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/AbeYuki/argocd-apps
    path: app-of-apps/testing
    targetRevision: HEAD
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: argocd
YAML
  depends_on = [
    module.common
  ]
}


