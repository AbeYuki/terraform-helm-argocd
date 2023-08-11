terraform {
  backend "s3" {
    bucket = "aimhighergg-tfstate"
    region = "ap-northeast-1"
    key = "helm-argocd.tfstate"
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
    config_path    = "~/.kube/config_k3s_node2"
    config_context = "k3s-node2"
  }
}
provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}