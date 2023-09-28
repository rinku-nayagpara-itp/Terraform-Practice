variable "instance_profile" {
  type        = string
  description = "The name of the instance profile for the infrastructure configuration."
}

variable "instance_types" {
  type        = list(string)
  description = "A list of EC2 instance types to use for the infrastructure configuration."
  default     = null
}

variable "infra_config_name" {
  type        = string
  description = "The name of the infrastructure configuration."
  default     = null
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs associated with the infrastructure configuration."
  default     = null
}

variable "sns_topic" {
  type        = string
  description = "The ARN of the SNS topic to receive notifications from the infrastructure configuration."
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to launch the instances in."
  default     = null
}

variable "description" {
  type    = string
  default = null
}


variable "logging" {
  type = object({
    s3_bucket_name = string
  })
  description = "Configuration for logging to an S3 bucket."
  default     = null
}

variable "infra_config_tags" {
  type        = map(string)
  description = "A map of tags to assign to the infrastructure configuration."
  default     = null
}

variable "block_device_mapping" {
  type = list(object({
    device_name = optional(string)
    ebs = optional(list(object({
      delete_on_termination = optional(bool)
      encrypted             = optional(bool)
      iops                  = optional(number)
      kms_key_id            = optional(string)
      snapshot_id           = optional(string)
      volume_size           = optional(number)
      volume_type           = optional(string)
    })))
  }))
  default     = []
  description = "EBS block device configuration for the instance"
}

variable "component" {
  type = list(object({
    parameter = optional(list(object({
      name  = string
      value = string
    })))
    component_arn = string
  }))
}

variable "image_recipe_name" {
  type = string
}

variable "recipe_parent_image" {
  type = string
}

variable "recipe_version" {
  type = string
}

variable "recipe_tags" {
  type    = map(string)
  default = null
}

variable "distribution_config_name" {
  type    = string
  default = null
}

variable "distribution_tags" {
  type    = map(string)
  default = null
}

variable "distribution" {
  type = list(object({
    ami_distribution_configuration = optional(list(object({
      name               = optional(string)
      description        = optional(string)
      target_account_ids = optional(list(string))
    })))
    region = string
  }))
}

variable "distributiin_tags" {
  type = map(string)
  default = null
}