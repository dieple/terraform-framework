variable "create_vault_kms" {
  type        = bool
  default     = false 
}
variable "description" {
  type        = string
  description = "Description"
  default     = ""
}
variable "alias_name" {
  type        = string
  description = "Alias Name"
  default     = ""
}
variable "deletion_window_in_days" {
  type        = number
  description = "Duration in days after which the key is permenently deleted"
  default     = 14
}
variable "enable_key_rotation" {
  type        = bool
  description = "Whether or not automated key rotation is enabled"
  default     = false
}
variable "policy" {
  description = "A valid KMS policy JSON document."
  default     = ""
}
