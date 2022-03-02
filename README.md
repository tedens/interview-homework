# Before getting started
Need to install kubectl, helm, terraform, aws cli

# IAM requirements
Create a user with admin policy attached then setup your aws credentials.
Could granulate the permissions needed but was not in the scope of the interview homework.

# Remote State
Create basic bucket and update info in terraform.tf for remote state management

# Create VPC and EKS cluster
`terraform init`
`terraform apply`

# Update kube config
Cluster name can be found from terraform output.
`aws eks update-kubeconfig --name $ClusterName --alias homework`

# Create kube namespace
`kubectl create namespace hw`

# Update dependency packages & Deploy ALB (/charts/aws-alb-ingress-controller/)
`helm dependency build`
Be sure to update clusterName in values.yaml
`helm install alb -n hw .`

# Deploy search-api pod (/charts/search-api/)
`helm  install search-api -n hw .`

# Deploy graph-api pod (/charts/graph-api/)
`helm  install graph-api -n hw .`

# Get alb urls
`kubectl get svc -n hw`