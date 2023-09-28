variable "description" {
  type    = string
  default = null
}
variable "enable_key_rotation" {
  type    = bool
  default = null
}
variable "deletion_window_in_days" {
  type    = number
  default = null
}
variable "tags" {
  type    = map(string)
  default = null
}
variable "policy" {
  type    = string
  default = null
}
variable "alias_name" {
  type    = string
  default = null
}
