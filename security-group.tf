# vim:ts=2:sw=2:et:

resource "aws_security_group" "db" {
  count = var.create_security_group ? 1 : 0
  
  name        = local.security_group_name
  description = var.identifier

  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  dynamic "ingress" {
    iterator = i
    for_each = var.security_group_rules
    content {
      from_port       = i.value.from_port
      to_port         = i.value.to_port
      protocol        = i.value.protocol
      self            = i.value.self
      cidr_blocks     = i.value.cidr_blocks
      security_groups = i.value.security_groups
      description     = i.value.description
    }
  }

  tags = merge(
    var.tags,
    map("Name", local.security_group_name)
  )
}

output "security-group" {
  value = aws_security_group.db[0]
}

