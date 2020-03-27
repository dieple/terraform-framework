output "zone_names" {
  value = var.zone_names
}

output "zone_id" {
  value = aws_route53_zone.default.*.zone_id
}

output "records" {
  value = aws_route53_zone.default.*.name_servers
}