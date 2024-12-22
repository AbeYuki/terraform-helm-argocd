resource "kubernetes_namespace" "argocd" {
  metadata {
    labels = {
      "kubernetes.io/metadata.name" = "argocd"
      "name"                        = "argocd"
    }
    name = "argocd"
  }
}

resource "kubernetes_secret" "argocd_vault_plugin" {
  metadata {
    name      = "argocd-vault-plugin-credentials"
    namespace = "argocd"
  }
  data = {
    "AVP_AUTH_TYPE" = "k8s"
    "AVP_K8S_ROLE"  = "argocd"
    "AVP_TYPE"      = "vault"
    "VAULT_ADDR"    = "http://vault.vault.svc.cluster.local:8200"
  }
  type = "Opaque"
  depends_on = [
    kubernetes_namespace.argocd
  ]
}

resource "helm_release" "argocd" {
  name             = "argocd"
  wait             = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "7.7.11"
  create_namespace = true
  set {
    name  = "server.service.type"
    value = "NodePort"
  }
  values = [
    file("${path.module}/values.yaml")
  ]
  depends_on = [
    kubernetes_secret.argocd_vault_plugin
  ]
}
