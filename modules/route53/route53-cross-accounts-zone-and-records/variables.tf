variable "zone_names" {
  type = list(string)
}

variable "root_share_zone_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "region" {
  type = string
}

variable "bucket_region" {
  type = string
}

variable "workspace_iam_role" {
  type = string
}

variable "share_r53_iam_role" {
  type = string
}
