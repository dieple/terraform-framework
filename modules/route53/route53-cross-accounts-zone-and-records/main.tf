provider "aws" {
  version = "~> 2.53"
  region  = var.region
  assume_role {
    role_arn = var.workspace_iam_role
  }
}

provider "aws" {
  alias  = "share_r53_iam_role"
  version = "~> 2.53"
  region  = var.bucket_region
  assume_role {
    role_arn = var.share_r53_iam_role
  }
}

resource "aws_route53_zone" "default" {
  count         = length(var.zone_names)
  name          = element(var.zone_names, count.index)
  tags          = var.tags
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