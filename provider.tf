terraform {
  backend "s3" {
    bucket  = "aimhighergg-tfstate"
    region  = "ap-northeast-1"
    key     = "helm-argocd-oci.tfstate"
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
  }
}
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config_oci"
    config_context = "oci-rke-cluster"
  }
}
provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

provider "kubernetes" {
    config_path    = "~/.kube/config_oci"
    config_context = "oci-rke-cluster"
}
