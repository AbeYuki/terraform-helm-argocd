provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config_microk8s_node1"
    config_context = "microk8s"
  }
}