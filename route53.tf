resource "aws_route53_record" "databases" {
  for_each = local.databases

  zone_id = var.hosted_zone_id
  name    = "${each.key}-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.databases[each.key].private_ip]
}

resource "aws_route53_record" "applications" {
  for_each = local.applications

  zone_id = var.hosted_zone_id
  name    = "${each.key}-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.applications[each.key].private_ip]
}
