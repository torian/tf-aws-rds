# vim:ts=2:sw=2:et:

data "aws_iam_policy" "db" {
  count = var.monitoring_role_arn == "" && local.monitoring_enabled ? length(var.db_iam_policies) : 0
  arn   = "arn:aws:iam::aws:policy/service-role/${element(var.db_iam_policies, count.index)}"
}

