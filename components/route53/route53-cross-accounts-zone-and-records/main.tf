module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = []
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
}

resource "aws_route53_zone" "default" {
  count         = length(var.zone_names)
  name          = element(var.zone_names, count.index)
  tags          = module.tag_label.tags
  force_destroy = true
}

resource "aws_route53_record" "default" {
  count           = length(var.zone_names)
  name            = element(var.zone_names, count.index)
  zone_id         = var.root_share_zone_id
  ttl             = 300
  type            = "NS"
  allow_overwrite = true

  # Assume role on platform-shared
  provider =  aws.share_r53_iam_role

  records = [
    aws_route53_zone.default[count.index].name_servers[0],
    aws_route53_zone.default[count.index].name_servers[1],
    aws_route53_zone.default[count.index].name_servers[2],
    aws_route53_zone.default[count.index].name_servers[3],
  ]
}