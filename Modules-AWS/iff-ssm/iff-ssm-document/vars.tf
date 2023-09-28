variable "document_name" {
  type = string
}

variable "document_type" {
  type = string
}

variable "ssm_document_tags" {
  type    = map(string)
  default = null
}

variable "content" {
  type = string
}
