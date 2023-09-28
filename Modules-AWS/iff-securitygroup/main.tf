resource "aws_security_group" "security_group" {
  name        = var.name
  vpc_id      = var.vpc_id
  description = var.description
  dynamic "ingress" {
    for_each = var.sg_ingress == null ? [] : var.sg_ingress
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      description     = ingress.value.description
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
      prefix_list_ids = ingress.value.prefix_list_ids
    }
  }

  dynamic "egress" {
    for_each = var.sg_egress == null ? [] : var.sg_egress
    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      description     = egress.value.description
      cidr_blocks     = egress.value.cidr_blocks
      security_groups = egress.value.security_groups
      prefix_list_ids = egress.value.prefix_list_ids
    }
  }

  tags = var.tags
}

resource "aws_security_group_rule" "this" {
  for_each                 = var.additional_sg_rule == null ? {} : var.additional_sg_rule
  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  description              = each.value.description
  cidr_blocks              = each.value.cidr_blocks
  source_security_group_id = each.value.security_group == "self" ? aws_security_group.security_group.id : each.value.security_group
  prefix_list_ids          = each.value.prefix_list_ids
  security_group_id        = aws_security_group.security_group.id
  depends_on               = [aws_security_group.security_group]
}
