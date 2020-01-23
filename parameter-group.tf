# vim:ts=2:sw=2:et:

resource "aws_db_parameter_group" "db" {
  count = var.create_parameter_group ? 1 : 0

  name   = var.parameter_group_name != "" ? var.parameter_group_name : local.parameter_group_name
  family = var.parameter_group_family != "" ? var.parameter_group_family : local.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters
    iterator = p
    
    content {
      name         = p.value.name
      value        = p.value.value
      apply_method = lookup(p.value, "apply_method", null)
    }
  }

}

