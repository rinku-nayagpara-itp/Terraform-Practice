variable "cluster_identifier" {
  type = string
  default = null
}

variable "database_name" {
  type = string

}

variable "master_username" {
  type = string
  default = null
}

variable "master_password" {
  type = string
  default = null
}

variable "engine" {
  type = string
}

variable "engine_mode" {
  type = string
}

variable "backup_retention_period" {
  type = number
  default = null
}

variable "vpc_security_group_ids" {
  type = list(string)
  default = null
}

variable "storage_encrypted" {
  type = bool
  default = null
}

variable "db_subnet_group_name" {
  type = string
  default = null
}

variable "tags" {
  type = map(string)
  default = null
}

variable "scaling_configuration" {
  type = object({
    auto_pause               = optional(bool)
    max_capacity             = optional(number)
    min_capacity             = optional(number)
    seconds_until_auto_pause = optional(number)
  })
  default = null
}


variable "subnet_group_name" {
  type = string
  default = ""
}

variable "subnet_ids" {
  type = list(string)
}

variable "subnet_tags" {
  type = map(string)
  default = null
}

variable "subnet_group_description" {
  type = string
  default = ""
}