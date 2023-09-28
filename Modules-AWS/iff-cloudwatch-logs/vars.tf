variable "name" {
  type = string
  default = ""
}

variable "retention_in_days" {
  type = number
  default = null
}

variable "tags" {
  type = map(string)
  default = null
}