variable "name" {
  type    = string
  default = ""
}

variable "role" {
  type        = string
  default     = ""
  description = "The role to be attached to the instance profile"
}

variable "tags" {
  type = map(string)
}

variable "path" {
  type    = string
  default = ""
}