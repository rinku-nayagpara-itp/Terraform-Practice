variable "template_name_prefix" {
  type        = string
  description = "The prefix for the name of the Launch Template"
  default     = null
}

variable "description" {
  type        = string
  description = "The description of the Launch Template"
  default     = null
}

variable "ebs_optimized" {
  type        = bool
  description = "Specifies whether the instance is optimized for EBS I/O"
  default     = false
}

variable "image_id" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) to use for the instances"
  default     = null
}

variable "instance_type" {
  type        = string
  description = "The type of the EC2 instance"
  default     = null
}

variable "key_name" {
  type        = string
  description = "The name of the key pair to use for SSH access to the instances"
  default     = null
}

variable "user_data" {
  type        = string
  description = "The user data to provide when launching the instances"
  default     = null
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with the instances"
  default     = null
}

variable "launch_template_default_version" {
  type        = number
  description = "Specifies whether to set the new version as the default version"
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  type = string
  default = null
}

variable "block_device_mappings" {
  type = list(object({
    device_name  = optional(string)
    no_device    = optional(bool)
    virtual_name = optional(string)
    ebs = optional(list(object({
      delete_on_termination = optional(bool)
      encrypted             = optional(bool)
      kms_key_id            = optional(string)
      iops                  = optional(number)
      throughput            = optional(number)
      snapshot_id           = optional(string)
      volume_size           = optional(number)
      volume_type           = optional(string)
    })))
  }))
  description = "The block device mappings for the instances"
  default     = null
}

variable "cpu_options" {
  type = object({
    core_count       = optional(number)
    threads_per_core = optional(number)
  })
  description = "The CPU options for the instance"
  default     = null
}

variable "credit_specification" {
  type = object({
    cpu_credits = optional(string)
  })
  description = "The credit specification for the instance"
  default     = null
}

variable "iam_instance_profile" {
  type = object({
    name = optional(string)
    arn  = optional(string)
  })
  description = "The IAM instance profile for the instance"
  default     = null
}

variable "enable_monitoring" {
  type        = bool
  description = "Indicates whether detailed monitoring is enabled for the instance"
  default     = null
}

variable "network_interfaces" {
  type = list(object({
    associate_carrier_ip_address = optional(bool)
    associate_public_ip_address  = optional(bool)
    delete_on_termination        = optional(bool)
    description                  = optional(string)
    device_index                 = optional(number)
    interface_type               = optional(string)
    ipv4_addresses               = optional(list(string))
    ipv6_addresses               = optional(list(string))
    network_interface_id         = optional(string)
    private_ip_address           = optional(string)
    security_groups              = optional(list(string))
    subnet_id                    = optional(string)
  }))
  description = "The network interfaces attached to the instance"
  default     = null
}

variable "tag_specifications" {
  type    = list(object({
    resource_type = optional(string)
    tags = optional(map(string))
  }))
  default = null
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "disable_api_termination" {
  type = bool
  default = null
}
