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
for i in 40-eks/ 30-bastion/ 20-sg/ 10-vpc/ ; do cd $i; terraform destroy -auto-approve; cd .. ; done 
```

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

# What is the process EKS Cluster Upgradation with Work load shifting?

1. first we need to get another node group called green.
2. taint/cordon the green nodes, so that they should not get any pods scheduled
kubectl cordon ip-10-0-11-111.ec2.internal (green nodes)
kubectl cordon ip-10-0-12-90.ec2.internal (green nodes)

3. now upgrade your control plane, do it from AWS console [Control plan upgradation first]
4. upgrade green node group also 1.31 to 1.32 [Nodes upgradation second]
5. shift the workloads from 1.31 node group to 1.32 nodegroup

shift workloads to green node group
Uncordon green nodes to allow scheduling:
kubectl uncordon ip-10-0-11-219.ec2.internal
kubectl uncordon ip-10-0-12-82.ec2.internal

6. cordon blue nodes, cordon and uncordon are best options then taint and untaint
kubectl cordon ip-10-0-11-219.ec2.internal
kubectl cordon ip-10-0-12-82.ec2.internal

7. uncordon green nodes
kubectl uncordon ip-10-0-11-219.ec2.internal
kubectl uncordon ip-10-0-12-82.ec2.internal

8. drain blue nodes
kubectl drain --ignore-daemonsets ip-10-0-11-219.ec2.internal
kubectl drain --ignore-daemonsets ip-10-0-12-82.ec2.internal  getting error,because pod running
kubectl drain --ignore-daemonsets ip-10-0-11-219.ec2.internal --force
inform all stake holders, application teams. perform sanity testing
close the activity
