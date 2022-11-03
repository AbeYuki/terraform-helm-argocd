# terraform-helm-argocd
Deploy argocd using terraform's helm provider. Automatically deploy applications using gitops

## Description
Terraform の helm provider を利用し、ArgoCD にアプリケーションを内包した状態で deploy することによって、gitops 環境構築しつつ、アプリケーションリソースの自動展開を行う。

## Notes
secret, cert-manaer-crd リソースについてはで ArgoCD から Sync 処理を行う前に deploy する。  

## Pay attention
provider.tf の kubeconfig に注意して deploy を行う。