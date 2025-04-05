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


##  CI/CD branch戦略
### staging
1. `make deploy-staging` # staging 環境にデプロイ

### production
1. `git checkout feat/branch`
2. `gh pr create` # production 環境にドライラン
3. `gh pr merge` # production 環境にデプロイ
