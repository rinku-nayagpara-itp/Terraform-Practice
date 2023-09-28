variable "role_name" {
  default     = "EC2InstanceRole"
  description = "Name of the IAM Role"
  type        = string
}

variable "path" {
  type        = string
  default     = "/"
  description = "path of the role"
}

variable "assume_role_policy" {
  type        = string
  default     = ""
  description = "jsonencoded assumed role policy"
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = []
  description = "list of the managed policy arns"
}

variable "tags" {
  type = map(string)
}
