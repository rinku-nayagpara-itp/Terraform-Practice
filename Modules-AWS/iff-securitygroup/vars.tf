
variable "name" {
  type        = string
  description = "Prefix for the security group names"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "description" {
  type        = string
  description = "description of sg"
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags for the security groups"
}

variable "sg_ingress" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    description     = optional(string)
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
    prefix_list_ids = optional(list(string))
  }))
  default     = null
  description = "Ingress rules for the security group"
}

variable "sg_egress" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    description     = optional(string)
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
    prefix_list_ids = optional(list(string))
  }))
  default     = null
  description = "Egress rules for the security group"
}

variable "additional_sg_rule" {
  type = map(object({
    type            = string
    from_port       = number
    to_port         = number
    protocol        = string
    description     = optional(string)
    cidr_blocks     = optional(list(string))
    security_group  = optional(string)
    prefix_list_ids = optional(list(string))
  }))
  default = null
}
