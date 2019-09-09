# vim:ts=2:sw=2:et:

resource "aws_route53_record" "db" {
  count = var.route53_create_record && var.route53_record != "" ? 1 : 0

  zone_id = var.route53_zone_id
  name    = var.route53_record
  type    = "CNAME"
  records = [ aws_db_instance.db.address ]
  ttl     = var.route53_record_ttl
}

#output "dns-record" {
#  value = var.create_route53_record ? aws_route53_record.record
#}

