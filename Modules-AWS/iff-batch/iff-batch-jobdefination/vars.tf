variable "name" {
  type = string
}

variable "type" {
  type = string
}

variable "container_properties" {
  type = string
}

variable "retry_strategy" {
  type = object({
    attempts = optional(number)
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "platform_capabilities" {
  type = list(string)
  default = null
}