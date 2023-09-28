variable "subnets" {
  type        = list(string)
  description = "list of subnets to mount the fs to"
}

variable "vpc_id" {
  type        = string
  description = "id of the vpc where the subnets and the fs should live"
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "default_name_prefix" {}
