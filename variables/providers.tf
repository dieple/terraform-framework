provider "aws" {
  version = "2.53"
  region  = lookup(var.envs[terraform.workspace], "region")
}

provider "aws" {
  alias  = "share_r53_iam_role"
  version = "~> 2.53"
  region  = lookup(var.envs[terraform.workspace], "region")
}
