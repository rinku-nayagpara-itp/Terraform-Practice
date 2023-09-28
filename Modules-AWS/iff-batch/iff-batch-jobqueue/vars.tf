variable "name" {
  type    = string
}

variable "state" {
  type    = string
}

variable "priority" {
  type    = number
}

variable "compute_environments" {
  type    = list(string)
}

variable "tags" {
  type    = map(string)
  default = null
}
