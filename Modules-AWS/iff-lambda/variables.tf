variable "function_name" {
  type        = string
  description = "The name of the AWS Lambda function"
  default     = null
}

variable "description" {
  type    = string
  default = null
}

variable "handler" {
  type        = string
  description = "The name of the handler function within the AWS Lambda function code"
  default     = null
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the AWS Lambda function"
  default     = null
}

variable "vpc_config" {
  type = list(object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  }))
  default = null
}

variable "environment" {
  type = list(object({
    variables = optional(map(string))
  }))
  default = []
}

variable "role_arn" {
  type        = string
  description = "The ARN of the IAM role that the AWS Lambda function assumes"
  default     = null
}

variable "timeout" {
  type        = number
  description = "The amount of time in seconds that the AWS Lambda function has to run before it times out"
  default     = null
}

variable "memory_size" {
  type        = number
  description = "The amount of memory in megabytes that is allocated to the AWS Lambda function"
  default     = null
}

variable "filename" {
  type        = string
  description = "The filename of the AWS Lambda function code"
  default     = null
}

variable "source_code_hash" {
  type        = string
  description = "The source code hash of the AWS Lambda function code"
  default     = null
}

variable "source_file" {
  type        = string
  description = "The source  of the AWS Lambda function code"
  default     = null
}

variable "tracing_config" {
  type        = string
  description = "The tracing AWS Lambda Monitoring"
  default     = null
}

variable "tags" {
  description = "Custom tags which can be passed on to the AWS resources. They should be key value pairs having distinct keys"
  type        = map(string)
  default     = {}
}

variable "s3_bucket" {
  type    = string
  default = null
}

variable "s3_key" {
  type    = string
  default = null
}


variable "action" {
  type    = string
  default = ""
}

variable "principal" {
  type    = string
  default = ""
}

variable "principal_source_arn" {
  type    = string
  default = ""
}

variable "invoke_function" {
  type = list(object({
    action = string
    principal = string 
    principal_source_arn = optional(string)
  }))
  default = []
}