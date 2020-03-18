output "key_name" {
  value = module.aws_key_pair.key_name
}

output "public_key" {
  value = module.aws_key_pair.public_key
}

output "private_key" {
  sensitive   = true
  value = module.aws_key_pair.private_key
}

output "public_key_filename" {
  value = module.aws_key_pair.public_key_filename
}

output "private_key_filename" {
  value = module.aws_key_pair.private_key_filename
}
