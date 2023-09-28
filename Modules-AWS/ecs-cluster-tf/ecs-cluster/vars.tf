variable "name" {
  type        = string
  description = "name of the ECS cluster"
  default     = null
}

variable "setting_name" {
  type = string
  description = "Name of the setting to manage."
  default = "containerInsights"
}

variable "setting_value" {
  type = string
  description = "value to assign to the setting"
  default = "enabled"
}

# capacity providers

variable "capacity_providers" {
  type        = list(string)
  description = "list of the names of capacity proiders"
  default     = null
}

variable "default_capacity_provider" {
  type = list(object({
    capacity_provider = string
    weight            = number
  }))
  default = []
}

# cloudwatch logs

variable "cloudwatch_log_group_name" {
  type        = string
  description = "name of teh cloudwatch log group"
  default     = null
}

variable "log_retention_days" {
  type        = number
  description = "retention days for the logs"
  default     = 0
}

# task definition

variable "ecs_task_definition" {
  type = list(object({
    family                   = string
    container_definition     = string
    requires_compatibilities = optional(list(string))
    network_mode             = optional(string)
    cpu                      = optional(number)
    memory                   = optional(number)
    execution_role_arn       = optional(string)
    task_role_arn            = optional(string)
    task_tags                = map(string)
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "cluster_setting" {
  type = list(object({
    name = string
    value = string
  }))
  default = []
}
