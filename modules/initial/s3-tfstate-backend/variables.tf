variable "customer" {
  type        = string
  description = "Customer name"
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "product" {
  type        = string
  description = "Product name"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  description = "Additional attributes (e.g. `state`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "region" {
  type        = string
  description = "AWS Region the S3 bucket should reside in"
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply to the S3 bucket"
  default     = "private"
}

variable "read_capacity" {
  default     = 5
  type        = number
  description = "DynamoDB read capacity units"
}

variable "write_capacity" {
  default     = 5
  type        = number
  description = "DynamoDB write capacity units"
}

variable "force_destroy" {
  description = "A boolean that indicates the S3 bucket can be destroyed even if it contains objects. These objects are not recoverable"
  default     = false
  type        = bool
}

variable "mfa_delete" {
  description = "A boolean that indicates that versions of S3 objects can only be deleted with MFA. ( Terraform cannot apply changes of this value; https://github.com/terraform-providers/terraform-provider-aws/issues/629 )"
  default     = false
  type        = bool
}

variable "enable_server_side_encryption" {
  description = "Enable DynamoDB server-side encryption"
  default     = true
  type        = bool
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  default     = false
  type        = bool
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = false
  type        = bool
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  default     = false
  type        = bool
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  default     = false
  type        = bool
}

variable "regex_replace_chars" {
  type        = "string"
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}

variable "prevent_unencrypted_uploads" {
  type        = bool
  default     = true
  description = "Prevent uploads of unencrypted objects to S3"
}

variable "profile" {
  type        = string
  default     = ""
  description = "AWS profile name as set in the shared credentials file"
}

variable "role_arn" {
  type        = string
  default     = ""
  description = "The role to be assumed"
}

variable "terraform_backend_config_file_name" {
  type        = string
  default     = "terraform.tf"
  description = "Name of terraform backend config file"
}

variable "terraform_backend_config_file_path" {
  type        = string
  default     = ""
  description = "The path to terrafrom project directory"
}

variable "terraform_version" {
  type        = string
  default     = "0.11.3"
  description = "The minimum required terraform version"
}

variable "terraform_state_file" {
  type        = string
  default     = "terraform.tfstate"
  description = "The path to the state file inside the bucket"
}

variable "allowed_remote_accounts" {
  type    = list(string)
  default = []
}

variable "cost_centre" {
  default = ""
  type    = string
}
