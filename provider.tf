terraform {
  backend "s3" {
    bucket = "aimhighergg-tfstate"
    region = "ap-northeast-1"
    key = "helm-argocd-minikube.tfstate"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.10.1"
    }
  }
}
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/minikube"
    config_context = "minikube"
  }
}
provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}