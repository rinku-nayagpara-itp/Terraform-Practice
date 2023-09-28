variable "appautoscaling_policy" {
  type = map(object({
    policy_name = string
    policy_type = optional(string)
    target_tracking_scaling_policy_configuration = optional(object({
      target_value = number
      predefined_metric_specification = optional(object({
        predefined_metric_type = string
      }))
    }))
  }))
}

# app autoscaling target

variable "appautoscaling_target" {
  type = map(object({
    max_capacity       = number
    min_capacity       = number
    resource_id        = string
    scalable_dimension = string
    service_namespace  = string
    role_arn           = optional(string)
  }))
}
