variable "imagebuilder_pipeline_name" {
  type        = string
  description = "The name of the image pipeline."
}

variable "pipeline_tags" {
  type        = map(string)
  description = "A map of tags to assign to the image pipeline."
  default     = null
}

variable "pipeline_description" {
  type        = string
  description = "The description of the image pipeline."
  default     = null
}

variable "image_tests_configuration" {
  type = object({
    image_tests_enabled = bool
    timeout_minutes     = number
  })
  description = "Configuration for image tests."
  default     = null
}

variable "schedule" {
  type = object({
    schedule_expression                = string
    pipeline_execution_start_condition = string
  })
  description = "Configuration for the pipeline schedule."
  default     = null
}

variable "status" {
  type        = string
  description = "The status of the image pipeline."
  default     = null
}

variable "image_recipe_arn" {
  type    = string
  default = null
}

variable "infrastructure_configuration_arn" {
  type = string
}

variable "distribution_configuration_arn" {
  type    = string
  default = null
}
