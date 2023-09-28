variable "name" {
  type    = string
  default = ""
}

variable "cluster" {
  type    = string
  default = ""
}

variable "task_definition" {
  type    = string
  default = ""
}

variable "launch_type" {
  type    = string
  default = ""
}

variable "platform_version" {
  type    = string
  default = ""
}

variable "desired_count" {
  type    = number
  default = 0
}

variable "deployment_maximum_percent" {
  type    = number
  default = 0
}

variable "deployment_minimum_healthy_percent" {
  type    = number
  default = 0
}

variable "network_configuration" {
  type = object({
    subnets         = list(string)
    security_groups = optional(list(string))
  })
  default = {
    subnets         = []
    security_groups = []
  }
}

variable "load_balancer" {
  type = object({
    container_name   = string
    container_port   = number
    target_group_arn = optional(string)
  })

}

variable "tags" {
  type    = map(string)
  default = {}
}
