resource "aws_appautoscaling_target" "ecs_target" {
  for_each           = var.appautoscaling_target
  max_capacity       = each.value.max_capacity
  min_capacity       = each.value.min_capacity
  resource_id        = each.value.resource_id
  scalable_dimension = each.value.scalable_dimension
  service_namespace  = each.value.service_namespace
  role_arn           = each.value.role_arn
}

resource "aws_appautoscaling_policy" "example" {
  for_each           = var.appautoscaling_policy
  name               = each.value.policy_name
  policy_type        = each.value.policy_type
  resource_id        = element([for idx, val in aws_appautoscaling_target.ecs_target : val.resource_id], index(keys(var.appautoscaling_policy), each.key))
  scalable_dimension = element([for idx, val in aws_appautoscaling_target.ecs_target : val.scalable_dimension], index(keys(var.appautoscaling_policy), each.key))
  service_namespace  = element([for idx, val in aws_appautoscaling_target.ecs_target : val.service_namespace], index(keys(var.appautoscaling_policy), each.key))

  target_tracking_scaling_policy_configuration {
    target_value = each.value.target_tracking_scaling_policy_configuration.target_value
    predefined_metric_specification {
      predefined_metric_type = each.value.target_tracking_scaling_policy_configuration.predefined_metric_specification.predefined_metric_type
    }
  }
}
