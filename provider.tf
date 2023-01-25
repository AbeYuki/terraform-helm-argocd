provider "helm" {
  backend "kubernetes" {
    secret_suffix  = "onpremises-helm-argocd"
    config_path    = "~/.kube/config_microk8s_node1"
    namespace      = "terraform"
    config_context = "microk8s-node1"
  }
  kubernetes {
    config_path    = "~/.kube/config_microk8s_node2"
    config_context = "microk8s-node2"
  }
}