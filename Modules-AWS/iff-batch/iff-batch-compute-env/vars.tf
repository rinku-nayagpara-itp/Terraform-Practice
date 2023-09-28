variable "compute_environment_name" {
  type = string
}

variable "compute_resources" {
  type = object({
    instance_role       = optional(string)
    allocation_strategy = optional(string)
    instance_type       = optional(list(string))
    launch_template = optional(object({
      launch_template_id = optional(string)
      version            = optional(string)
    }))
    ec2_configuration = optional(list(object({
      image_type = optional(string)
    })))
    desired_vcpus      = optional(number)
    min_vcpus          = optional(number)
    max_vcpus          = optional(number)
    security_group_ids = optional(list(string))
    subnets            = optional(list(string))
    type               = string
    tags               = optional(map(string))
  })
}

variable "service_role" {
  type = string
}

variable "type" {
  type = string
}