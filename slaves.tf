# vim:ts=2:sw=2:et:

resource "aws_db_instance" "slave" {
  count = var.slave_count

  identifier             = "${var.identifier}-slave-${count.index + 1}"
  replicate_source_db    = aws_db_instance.db.identifier

  engine                 = var.engine
  engine_version         = var.engine_version
  port                   = local.port
  availability_zone      = local.availability_zone
  multi_az               = var.multi_az
  publicly_accessible    = false
  vpc_security_group_ids = local.security_group_ids
  parameter_group_name   = var.create_parameter_group ? aws_db_parameter_group.db[0].id : null

  instance_class         = var.slave_instance_class
  storage_type           = local.storage_type
  iops                   = local.iops
  storage_encrypted      = var.storage_encrypted
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  ca_cert_identifier     = var.ca_cert_identifier

  monitoring_interval          = var.monitoring_interval
  performance_insights_enabled = local.monitoring_enabled ? var.performance_insights_enabled : false
  monitoring_role_arn          = local.monitoring_enabled ? (var.monitoring_role_arn != "" ? var.monitoring_role_arn : aws_iam_role.db[0].arn) : null

  iam_database_authentication_enabled = var.iam_auth_enabled

  username = local.admin_user

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.minor_version_upgrade
  maintenance_window          = var.maintenance_window

  skip_final_snapshot        = true
  final_snapshot_identifier  = "${local.final_snapshot_id}-slave-${count.index + 1}"
  copy_tags_to_snapshot      = true

  deletion_protection = var.deletion_protection

  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports

  apply_immediately   = var.apply_immediately

  tags = var.tags
}

output "slaves" {
  value = var.slave_count > 0 ? aws_db_instance.slave : null
}

