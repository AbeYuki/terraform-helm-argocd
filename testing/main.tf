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
