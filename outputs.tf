output "instance_ids" {
  description = "EC2 instance IDs for all 13 RoboShop components."
  value = merge(
    { for name, instance in aws_instance.databases : name => instance.id },
    { for name, instance in aws_instance.applications : name => instance.id },
  )
}

output "private_ips" {
  description = "Private IP addresses for all 13 RoboShop instances."
  value = merge(
    { for name, instance in aws_instance.databases : name => instance.private_ip },
    { for name, instance in aws_instance.applications : name => instance.private_ip },
  )
}

output "public_ips" {
  description = "Public IP addresses for all 13 RoboShop instances."
  value = merge(
    { for name, instance in aws_instance.databases : name => instance.public_ip },
    { for name, instance in aws_instance.applications : name => instance.public_ip },
  )
}

output "dns_records" {
  description = "Route53 A record names for all 13 RoboShop components."
  value = merge(
    { for name, record in aws_route53_record.databases : name => record.fqdn },
    { for name, record in aws_route53_record.applications : name => record.fqdn },
  )
}

output "dns_private_ip_mapping" {
  description = "DNS name to private IP mapping for all 13 RoboShop components."
  value = merge(
    { for name, record in aws_route53_record.databases : record.fqdn => aws_instance.databases[name].private_ip },
    { for name, record in aws_route53_record.applications : record.fqdn => aws_instance.applications[name].private_ip },
  )
}

output "default_vpc_id" {
  description = "Default VPC used by the RoboShop instances."
  value       = data.aws_vpc.default.id
}

output "environment" {
  description = "Deployment environment."
  value       = var.environment
}
