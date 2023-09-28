resource "aws_lb" "alb" {
  internal           = var.internal
  name               = var.name
  load_balancer_type = "application"
  # access_logs {
  #   bucket  = var.access_logs.bucket
  #   prefix  = var.access_logs.prefix
  #   enabled = var.access_logs.enabled
  # }
  idle_timeout    = var.idle_timeout
  security_groups = var.security_groups
  subnets         = var.subnets
  tags            = var.tags
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  for_each          = var.lb_listener
  port              = each.value.port
  protocol          = each.value.protocol
  certificate_arn   = each.value.certificate_arn
  default_action {
    target_group_arn = length(var.lb_listener)==length(var.target_group)? element([for idx, val in aws_lb_target_group.target_group : val.arn], index(keys(var.lb_listener), each.key)) : local.target_groups_arn[0]
    type             = each.value.default_action.type
  }
}

resource "aws_lb_target_group" "target_group" {
  for_each    = var.target_group
  name        = each.value.name
  port        = each.value.port
  protocol    = each.value.protocol
  target_type = each.value.target_type
  vpc_id      = each.value.vpc_id
  dynamic "health_check" {
    for_each = each.value.health_check == null ? [] : [each.value.health_check]
    content {
      path     = health_check.value.path
      matcher  = health_check.value.matcher
      interval = health_check.value.interval
    }
  }
  tags = each.value.tags
}

locals {
  target_groups_arn = [for idx, val in aws_lb_target_group.target_group : val.arn]
}

resource "aws_lb_target_group_attachment" "this" {
  count            = var.target_id== null ? 0 : length(var.target_id)
  target_group_arn = local.target_groups_arn[count.index]
  target_id        = var.target_id[count.index]
  port             = var.target_port[count.index]
}
