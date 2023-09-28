variable "sns_topic_name" {
  type        = string
  description = "The name of the SNS topic"
  default = null
}

variable "display_name" {
  type        = string
  description = "The Display name of the SNS topic"
  default = null
}

variable "sns_access_policy" {
  type        = string
  description = "The file path of the SNS access policy JSON file"
  default = null
}

variable "sns_delivery_policy" {
  type        = string
  description = "The file path of the SNS delivery policy JSON file"
  default = null
}


variable "sns_topic_subscription" {
  type        = map(object({
    protocol = string
    endpoint = string
  }))
  description = "The email address to subscribe to the SNS topic"
  default = {}
}

variable "tags" {
  description = "Custom tags which can be passed on to the AWS resources. They should be key value pairs having distinct keys"
  type        = map(string)
  default     = {}
}
