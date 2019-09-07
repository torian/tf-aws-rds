# vim:ts=2:sw=2:et:

resource "aws_iam_role" "db" {
  count = var.monitoring_role_arn == "" && local.monitoring_enabled ? 1 : 0

  name               = local.monitoring_role_name
  assume_role_policy = data.aws_iam_policy_document.assume-role[0].json
  tags               = var.tags
}

data "aws_iam_policy_document" "assume-role" {
  count = var.monitoring_role_arn == "" && local.monitoring_enabled ? 1 : 0

  statement {
    sid       = "AssumeRole"
    effect    = "Allow"
    actions   = [ "sts:AssumeRole" ]
    principals {
      type        = "Service"
      identifiers = [ "monitoring.rds.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "db" {
  count = var.monitoring_role_arn == "" && local.monitoring_enabled ? length(var.db_iam_policies) : 0

  role       = aws_iam_role.db[0].name
  policy_arn = data.aws_iam_policy.db[count.index].arn
}

output "iam-role" {
  value = var.monitoring_role_arn == "" && local.monitoring_enabled ? aws_iam_role.db : null
}

