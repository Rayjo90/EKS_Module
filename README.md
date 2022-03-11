# EKS_Module
Terraform creation of EKS cluster and 3 nodes.

# This Terraform code is used to define eks cluster and eks node group for testing purpose

### It Will create below resources

- eks cluster
- eks node group
  with required role and policy

- vpc
- subnet (public and private)
- routing table
- Nat Gateway
- Internet Gateway
- Elastic Ip

## Steps to run terraform code

```hcl
terraform init
terraform plan
terraform apply --auto-approve
```

## To access eks cluster

```hcl
aws eks update-kubeconfig   --name eks --role-arn arn:aws:iam::226273005523:role/EKS-Cluster-Role --region us-east-1


kubectl get pods
```
