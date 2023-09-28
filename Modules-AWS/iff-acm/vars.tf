variable "domain_name" {
  type = string
}

variable "validation_method" {
  type = string
}

variable "validation_record_fqdns" {
  type    = list(string)
  default = [""]
}

variable "certificate_transparency_logging_preference" {
  type    = string
  default = null
}

variable "pub_zone_id" {
  type = string
}
