variable "bucket" {
  type = string
}

variable "acl" {
  default = null
  type    = string
}

variable "force_destroy" {
  type    = bool
  default = null
}

variable "logging" {
  type = object({
    target_bucket = optional(string)
  })
  default = null
}

variable "versioning_enabled" {
  type    = bool
  default = false
}

variable "server_side_encryption_configuration" {
  type = object({
    rule = object({
      apply_server_side_encryption_by_default = object({
        sse_algorithm = string
      })
    })
  })
  default = null
}

variable "file_key" {
  type    = list(string)
  default = []
}

variable "file_source" {
  type    = list(string)
  default = [""]
}

variable "tags" {
  type = map(string)
}

variable "lifecycle_rules" {
  type = list(object({
    rule = optional(list(object({
      status = string
      id     = string
      transition = optional(list(object({
        days          = optional(number)
        storage_class = string
      })))
    })))
  }))
  default = null
}

variable "s3_public_access" {
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}
