resource "helm_release" "argocd" {
  name             = "argocd"
  timeout          = 600000
  wait             = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.25.0"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "NodePort"
  }
}