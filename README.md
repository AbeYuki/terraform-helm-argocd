# terraform-helm-argocd

## argocd helm
https://github.com/argoproj/argo-helm

### deploy

```
kubectl create ns argocd
```
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

## TF ファイルを新規作成した場合はリンクを再作成
```
$ls
README.md  common  production  staging  testing
```
```
for i in production staging testing
do
    ln -sr common/* ${i}/ 2>/dev/null
done
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

