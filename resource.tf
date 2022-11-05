resource "helm_release" "argocd" {
  name             = "v-5-13-2-argocd"
  timeout          = 600000
  wait             = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.13.2"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  values = [
    file("argocd/application.yaml")
  ]
}