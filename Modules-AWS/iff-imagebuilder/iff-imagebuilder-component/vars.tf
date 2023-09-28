variable "components" {
  type = list(object({
    name               = string
    platform           = string
    version            = string
    data               = string
    description        = optional(string)
    change_description = optional(string)
    tags               = optional(map(string))
  }))
}
