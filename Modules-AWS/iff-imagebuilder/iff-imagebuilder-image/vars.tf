variable "distribution_configuration_arn" {
  type    = string
  default = null
}

variable "image_recipe_arn" {
  type    = string
  default = null
}

variable "infrastructure_configuration_arn" {
  type = string
}

variable "tags" {
  type = map(string)
  default = null
}