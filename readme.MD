# Infrastructure creation and deletion

```
for i in  10-vpc/ 20-sg/ 30-bastion 40-eks ; do cd $i; terraform init -reconfigure; cd .. ; done 
```

```
for i in  10-vpc/ 20-sg/ 30-bastion 40-eks ; do cd $i; terraform plan; cd .. ; done 
```

```
for i in  10-vpc/ 20-sg/ 30-bastion 40-eks ; do cd $i; terraform apply -auto-approve; cd .. ; done 
```

```
for i in 40-eks/ 30-bastion/ 20-sg/ 10-vpc/ ; do cd $i; terraform destroy auto-approve; cd .. ; done 


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
* Connect to Bastion Server:SSH to bastion host
* run below command and configure the credentials.
```
aws configure
```
* Checking connection with AWS:
```
aws s3 ls
```
* get the kubernetes config using below command
```
aws eks update-kubeconfig --region us-east-1 --name expense-dev
```
* Now you should be able to connect K8 cluster
```
kubectl get nodes
```


ec2-user$cat .kube/config

git clone https://github.com/Lingaiahthammisetti/9.3.k8s-resources.git
cd 9.3.k8s-resources
kubectl apply -f 02-pod.yaml
kubectl get pods
kubectl get pods -o wide --> We can see in which node nginx pod running

go to eks folder and uncomment green nodes, apply them

kubectl apply -auto-approve

kubectl get nodes