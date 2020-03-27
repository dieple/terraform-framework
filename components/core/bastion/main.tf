module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["bastion"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = lookup(var.envs[terraform.workspace], "bucket")
    key            = format("env:/%s/%s/%s", terraform.workspace, "vpc", "terraform.tfstate")
    region         = lookup(var.envs[terraform.workspace], "bucket_region")
    dynamodb_table = lookup(var.envs[terraform.workspace], "dynamodb")
  }
}

module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.4.0"
  
  name        = "${module.tag_label.id}-sg"
  description = "bastion security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  egress_rules        = ["all-all"]
  ingress_with_cidr_blocks = [
   {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh from VPN"
      cidr_blocks = var.vpn_ip
    },
  ]
}

module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"
  name                   = "${module.tag_label.id}"
  
  ami                    = var.bastion_ami_id
  instance_type          = var.bastion_instance_type
  vpc_security_group_ids = [module.bastion_sg.this_security_group_id]
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  key_name               = aws_key_pair.generated.key_name

  tags                   = module.tag_label.tags
}