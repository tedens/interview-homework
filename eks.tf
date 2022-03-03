# Create EKS module
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  version = "16.2.0"

  tags = {
    Environment = "dev"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }
  enable_irsa = true

  node_groups = {
    nodes = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      k8s_labels = {
        Environment = "dev"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }
      additional_tags = {
        ExtraTag = "Homework"
      }
    }
  }

  # Setting myself as admin for cluster access.
  map_users    = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/tj"
      username = "tj"
      groups   = ["system:masters"]
    },
  ]
}