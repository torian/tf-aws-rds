# vim:ts=2:sw=2:et:

resource "aws_route53_record" "db" {
  count = var.route53_create_record && var.route53_record != "" ? 1 : 0

  zone_id = var.route53_zone_id
  name    = var.route53_record
  type    = "CNAME"
  records = [ aws_db_instance.db.address ]
  ttl     = var.route53_record_ttl
}

resource "aws_route53_record" "slaves" {
  count = var.slave_count > 0 && var.slave_route53_record != "" ? var.slave_count : 0

  zone_id = var.route53_zone_id
  name    = "${var.slave_route53_record}-${count.index + 1}"
  type    = "CNAME"
  records = [ aws_db_instance.slave[count.index].address ]
  ttl     = var.route53_record_ttl
}

resource "aws_route53_record" "slave" {
  count = var.slave_count > 0 && var.slave_route53_record != "" ? 1 : 0

  zone_id = var.route53_zone_id
  name    = var.slave_route53_record
  type    = "CNAME"
  records = aws_db_instance.slave.*.address
  ttl     = var.route53_record_ttl
}

#output "dns-record" {
#  value = var.create_route53_record ? aws_route53_record.record
#}

