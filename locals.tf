# vim:ts=2:sw=2:et:

locals {
  
  engine_port = {
    postgres = 5432
    mysql    = 3306
  }

  port = var.port == 0 ? local.engine_port[var.engine] : var.port

  security_group_name   = var.security_group_name != "" ? var.security_group_name : "${var.identifier}-db-sg"
  security_group_ids    = var.create_security_group ? [ aws_security_group.db[0].id ] : var.security_group_ids

  availability_zone     = var.az != "" ? var.az : null

  iops                  = var.iops > 0 ? var.iops : null
  storage_type          = var.iops > 0 ? "io1" : var.storage_type

  parameter_group_family = "${var.engine}${replace(var.engine_version, "/.[0-9]+$/", "")}"
  parameter_group_name   = "${var.identifier}-${var.engine}-${replace(replace(var.engine_version, "/.[0-9]+$/", ""), ".", "-")}"

  monitoring_role_name = var.monitoring_role_name != "" ? var.monitoring_role_name : var.identifier
  monitoring_enabled   = var.monitoring_interval > 0 ? true : false

  db_name    = var.db_name != "" ? var.db_name : null
  admin_user = var.admin_user
  admin_pass = var.admin_pass

  final_snapshot_id       = var.final_snapshot_id == "" ? "${var.identifier}-final" : var.final_snapshot_id
}

