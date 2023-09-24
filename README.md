# terraform-helm-argocd

## argocd helm
https://github.com/argoproj/argo-helm


## add crd

### cer-manaer
https://cert-manager.io/docs/installation/helm/
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.crds.yaml
```

### get argocd secert
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

## Pay attention
provider.tf の kubeconfig に注意して deploy を行う。

## metallb

```
kubectl apply -f - <<EOF
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.0.0-192.168.0.0
  - 192.168.0.0/32
EOF
```