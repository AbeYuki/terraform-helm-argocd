terraform {
  backend "s3" {
    bucket  = "aimhighergg-tfstate"
    region  = "ap-northeast-1"
    key     = "helm-argocd.tfstate"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
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

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config_k3s_node2"
    config_context = "k3s-node2"
  }
}
provider "kubernetes" {
  config_path    = "~/.kube/config_k3s_node2"
  config_context = "k3s-node2"
}
provider "kubectl" {
  config_path    = "~/.kube/config_k3s_node2"
  config_context = "k3s-node2"
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
    repoURL: https://github.com/AbeYuki/argocd
    path: app-of-apps-root/production
    targetRevision: HEAD
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: argocd
YAML
  depends_on = [
    module.common
  ]
}