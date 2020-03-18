variable "key_name" {
  type        = string
  description = "ssh key name"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key directory (e.g. `/secrets`)"
}

variable "generate_ssh_key" {
  type        = bool
  description = "If set to `true`, new SSH key pair will be created"
}

variable "ssh_key_algorithm" {
  type        = string
  description = "SSH key algorithm"
}

variable "private_key_extension" {
  type        = string
  description = "Private key extension"
}

variable "public_key_extension" {
  type        = string
  description = "Public key extension"
}
