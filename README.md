# terraform-helm-argocd

## argocd helm
https://github.com/argoproj/argo-helm


## add crd
### argocd 
```
kubectl apply -k "https://github.com/argoproj/argo-cd/manifests/crds?ref=v2.8.0"
```

### cer-manaer
https://cert-manager.io/docs/installation/helm/
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml
```

### argocd secert
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

## Pay attention
provider.tf の kubeconfig に注意して deploy を行う。