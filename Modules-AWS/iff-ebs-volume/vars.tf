variable "availability_zone" {
  type = string
  description = "The availability zone to create EBS in"
}

variable "encrypted" {
  type = bool
  description = "The disk will be encrypted if true"
  default = false
}

variable "size" {
  type = number
  description = "The size of EBS volume"
  default = null
}

variable "snapshot_id" {
  type = string
  default = ""
  description = "The ID of the volume snapshot for base EBS"
}

variable "type" {
  type = string
  description = "The type of EBS volume"
  default = ""
}

variable "tags" {
  type = map(string)
  description = "Tags"
}

variable "iops" {
  type = number
  default = null
}

variable "multi_attach_enabled" {
  type = bool
  default = false
}