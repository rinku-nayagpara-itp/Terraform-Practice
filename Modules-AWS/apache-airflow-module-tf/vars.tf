variable "mwaa_name" {
  type        = string
  description = "Name of AWS MWAA environment"
}

variable "airflow_version" {
  type        = string
  description = "Version of airflow environment"
}

variable "window" {
  type        = string
  description = "Wekly maintainence window start date"
}

variable "bucket_arn" {
  type        = string
  description = "Source bucket ARN"
}

variable "dag_s3_path" {
  type        = string
  description = "Relative path to the DAG folder on your Amazon S3 storage bucket"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups IDs for the environment"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The private subnet IDs in which the environment should be created. Minimum 2"
}

variable "environment_class" {
  type        = string
  description = "Environment class for the cluster"
}

variable "schedulers" {
  type        = number
  description = "The number of schedulers that you want to run in your environment"
}

variable "max_workers" {
  type        = number
  description = "The maximum number of workers that can be automatically scaled up. Between 1-25"
  default     = 10
}

variable "min_workers" {
  type        = number
  description = "The minimum number of workers that you want to run in your environment."
  default     = 1
}

variable "role_arn" {
  type        = string
  description = "ARN of the task execution role that the Amazon MWAA and its environment can assume."
}

variable "key" {
  type        = string
  description = "ARN of KMS key used for encryption"
}

variable "airflow_configuration_options" {
  type = object({
    dag_concurrency = number
    parallelism     = number
    email_backend   = string
    smtp_mail_from  = string
    smtp_host       = string
    smtp_port       = number
    smtp_ssl        = bool
    smtp_starttls   = bool
  })
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags for the mwaa environment"
}
