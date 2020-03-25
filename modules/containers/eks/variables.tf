variable "node_groups" {}
variable "worker_disk_size" {}
variable "worker_ami_type" {}
variable "enable_irsa" {
  type = bool
}
variable "cluster_enabled_log_types" {
  default = []
}
variable "map_roles" {
  default = []
}

variable "cluster_name" {}
variable "vpc_id" {}
variable "subnets" {
  type = list(string)
}
variable "tags" {
  type = list(string)
}

variable "bucket" {}
variable "bucket_region" {}
variable "dynamodb" {}
variable "workspace" {}