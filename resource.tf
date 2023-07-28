resource "helm_release" "argocd" {
  name             = "argocd"
  timeout          = 600000
  wait             = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.41.1"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "NodePort"
  }
  values = [
    file("${path.module}/values.yaml")
  ]
resource "kubernetes_secret" "argocd_vault_plugin" {
  metadata {
    name      = "argocd-vault-plugin-credentials"
    namespace = "argocd"
  }
}