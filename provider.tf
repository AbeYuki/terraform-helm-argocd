provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config_microk8s_node2"
    config_context = "microk8s-node2"
  }
}