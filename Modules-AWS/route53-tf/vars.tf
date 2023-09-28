variable "name" {
  type    = string
}

variable "type" {
  type    = string
}

variable "zone_id" {
  type    = string
}

variable "alias" {
  type = object({
    name    = string
    zone_id = string
  })
  default = null
}

variable "records" {
  type = list(string)
  default = null
}

variable "ttl" {
  type = number
  default = 0 
}

variable "allow_overwrite" {
  type = bool
  default = false
}

