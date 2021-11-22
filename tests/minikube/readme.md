# Test using minikube

1. minikube start
2. tf init
3. tf apply
4. Test without ingress 
```shell
kubectl port-forward svc/argocd-server -n argocd 8080:443
```