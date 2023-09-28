variable "access_logs" {
  type = object({
    bucket  = string
    enabled = optional(bool)
    prefix  = optional(string)
  })
  default = null
}

variable "internal" {
  type    = bool
  default = false

}

variable "name" {
  type = string
}

variable "idle_timeout" {
  type    = number
  default = null
}

variable "subnets" {
  type    = list(string)
  default = []
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}


# target group

variable "target_group" {
  type = map(object({
    name        = string
    port        = optional(number)
    protocol    = optional(string)
    vpc_id      = optional(string)
    target_type = optional(string)
    tags        = optional(map(string))
    health_check = optional(object({
      path     = optional(string)
      matcher  = optional(string)
      interval = optional(number)
    }))
  }))
  default = {}
}


# listener
variable "lb_listener" {
  type = map(object({
    port            = optional(number)
    protocol        = optional(string)
    certificate_arn = optional(string)
    default_action = optional(object({
      type             = string
      target_group_arn = optional(string)
    }))
  }))
}

variable "target_id" {
  type    = list(string)
  default = null
}

variable "target_port" {
  type    = list(number)
  default = null
}
