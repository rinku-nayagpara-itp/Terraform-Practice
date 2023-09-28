variable "vpc_zone_identifier" {
  type    = list(string)
  default = [] 
}

variable "launch_template" {
  type = object({
    id      = optional(string)
    version = optional(string)
  })
  default = null 
}

variable "max_size" {
  type    = number
  default = null  
}

variable "min_size" {
  type    = number
  default = null
}

variable "desired_capacity" {
  type    = number
  default = null
}

variable "health_check_type" {
  type    = string
  default = null
}

variable "health_check_grace_period" {
  type    = number
  default = null
}

variable "default_cooldown" {
  type = number
  default = null
}

variable "target_group_arns" {
  type    = list(string)
  default = [] 
}

variable "tags" {
  type    = list(object({
    key   = string
    value = string
  }))
  default = []
}

variable "initial_lifecycle_hook" {
  type = list(object({
    lifecycle_transition     = string
    name                     = string
    heartbeat_timeout        = optional(number)
    notification_target_arn  = optional(string)
    role_arn                 = optional(string)
  }))
  default = [] 
}

variable "alert_topic_arn" {
  type = string
  default = null
}

variable "notifications" {
  type = list(string)
  default = null
}