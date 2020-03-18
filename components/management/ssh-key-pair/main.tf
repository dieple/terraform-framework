module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["ssh"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}

module "aws_key_pair" {
  source                = "../../../modules/management/ssh-key-pair"
  key_name              = var.key_name
  ssh_public_key_path   = var.ssh_public_key_path
  generate_ssh_key      = var.generate_ssh_key
  ssh_key_algorithm     = var.ssh_key_algorithm
  private_key_extension = var.private_key_extension
  public_key_extension  = var.public_key_extension
  tags                  = module.tag_label.tags
}


