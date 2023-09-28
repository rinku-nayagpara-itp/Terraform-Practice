variable "attribute" {
  type = list(object({
    name = string
    type = string
  }))
}

variable "name" {
  type = string
}

variable "read_capacity" {
  type = number
  default = null
}

variable "write_capacity" {
  type = number
  default = null
}

variable "hash_key" {
  type = string
  default = ""
}

variable "billing_mode" {
  type = string
  default = "PROVISIONED"
}