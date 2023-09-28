variable "name" {
  type    = string
  default = "secret"
}

variable "description" {
  type    = string
  default = "abc"
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "secret_string" {
  default = null
  type    = map(string)
}

variable "tags" {
  default = null
  type    = map(string)
}

variable "policy" {
  type    = string
  default = null
}
