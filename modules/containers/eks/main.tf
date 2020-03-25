provider "tls" {
  version = "~> 2.1"
}

provider "kubernetes" {
  version                = "1.10"
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "8.0.0"

  cluster_name              = var.cluster_name
  cluster_enabled_log_types = var.cluster_enabled_log_types
  vpc_id                    = var.vpc_id
  subnets                   = var.subnets
  enable_irsa               = var.enable_irsa

  node_groups_defaults      = {
    disk_size = var.worker_disk_size
    ami_type  = var.worker_ami_type
  }

  node_groups               = var.node_groups
  map_roles                 = var.map_roles
  tags                      = var.tags
}
