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
    "AVP_AUTH_TYPE"     = "k8s"
    "AVP_K8S_ROLE"      = "argocd"
    "AVP_TYPE"          = "vault"
    "VAULT_ADDR"        = "https://vault.vault.svc.cluster.local:8200"
    "VAULT_SKIP_VERIFY" = "false"
    "VAULT_CACERT"      = "/vault/tls/vault.ca"
    "VAULT_CLIENT_CERT" = "/vault/tls/vault.crt"
    "VAULT_CLIENT_KEY"  = "/vault/tls/vault.key"
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
  version          = "7.8.2"
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
