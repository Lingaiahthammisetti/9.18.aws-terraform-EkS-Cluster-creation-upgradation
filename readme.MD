# Infrastructure
Creating above infrastructure involves lot of steps, as maintained sequence we need to create
* VPC
* All security groups and rules
* Bastion Host
* EKS

## Sequence
* (Required). create VPC first
* (Required). create SG after VPC
* (Required). create bastion host. It is used to connect RDS and EKS cluster.
* (Optional). VPN, same as bastion but a windows laptop can directly connect to VPN and get access of RDS and EKS.

### Admin activities
**Bastion**
* SSH to bastion host
* run below command and configure the credentials.
```
aws configure
```
* get the kubernetes config using below command
```
aws eks update-kubeconfig --region us-east-1 --name expense-dev
```
* Now you should be able to connect K8 cluster
```
kubectl get nodes
```

login to bastion server:
aws configure
aws s3 ls
aws eks update-kubeconfig --region us-east-1 --name expense-dev

ec2-user$cat .kube/config

git clone https://github.com/Lingaiahthammisetti/9.3.k8s-resources.git
cd 9.3.k8s-resources
kubectl apply -f 02-pod.yaml
kubectl get pods
kubectl get pods -o wide --> We can see in which node nginx pod running

go to eks folder and uncomment green nodes, apply them

kubectl apply -auto-approve

kubectl get nodes