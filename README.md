# terraform-helm-argocd

## argocd helm

https://github.com/argoproj/argo-helm
https://artifacthub.io/packages/helm/argo/argo-cd

### deploy

```
terraform init
```
```
terraform plan
```
```
terraform apply
```

### get argocd secert
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

## testing 環境
```
minikube start
```
```
minikube kubectl config view > ~/.kube/minikube 
```

## 注意
- main.tf の kubeconfig に注意して deploy を行う
- tfstate 名はかぶらないようにする

