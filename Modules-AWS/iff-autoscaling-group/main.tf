resource "aws_autoscaling_group" "this" {
  vpc_zone_identifier = var.vpc_zone_identifier

  dynamic "launch_template" {
    for_each = length(var.launch_template) != 0 ? [1] : []
    content {
      id      = var.launch_template.id
      version = var.launch_template.version
    }
  }
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  target_group_arns         = var.target_group_arns
  default_cooldown = var.default_cooldown
  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = true
    }
  }
  dynamic "initial_lifecycle_hook" {
    for_each = length(var.initial_lifecycle_hook) == 0 ? [] : var.initial_lifecycle_hook
    content {
      lifecycle_transition    = initial_lifecycle_hook.value.lifecycle_transition
      name                    = initial_lifecycle_hook.value.name
      heartbeat_timeout       = initial_lifecycle_hook.value.heartbeat_timeout
      notification_target_arn = initial_lifecycle_hook.value.notification_target_arn
      role_arn                = initial_lifecycle_hook.value.role_arn
    }
  }
}

resource "aws_autoscaling_notification" "this" {
  count         = var.alert_topic_arn == 0 ? 0 : 1
  group_names   = [aws_autoscaling_group.this.name]
  topic_arn     = var.alert_topic_arn
  notifications = var.notifications
}
