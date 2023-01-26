# terraform-helm-argocd

## argocd helm
https://github.com/argoproj/argo-helm

### argocd secert
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

## Pay attention
provider.tf の kubeconfig に注意して deploy を行う。