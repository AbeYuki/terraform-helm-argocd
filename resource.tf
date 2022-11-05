resource "helm_release" "argocd" {
  name             = "argocd"
  timeout          = 600000
  wait             = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "4.13.2"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  values = [
    file("argocd/application.yaml")
  ]
}