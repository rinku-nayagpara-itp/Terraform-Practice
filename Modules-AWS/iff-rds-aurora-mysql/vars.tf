variable "application_name" {
  type = string
  default = ""
}

#-------- DB Cluster --------

variable "database_name" {
  type = string
  description = "Name of the database"
}

variable "backup_retention_period" {
  type        = number
  description = "Days to retain backups for"
}

variable "cluster_identifier" {
  type    = string
  default = "The cluster identifier"
}

variable "engine" {
  type        = string
  description = "Name of the database engine to be used for this DB cluster"
}

variable "master_username" {
  type        = string
  description = "Username for the master DB user"
}

variable "master_password" {
  type        = string
  description = "Password for the master DB user"
}

# variable "db_subnet_group_name" {
#   type        = string
#   description = "DB subnet group to associate with this DB instance"
# }

variable "enabled_cloudwatch_logs_exports" {
  type        = set(string)
  description = "Set of log types to export to cloudwatch"
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB cluster is encrypted"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security groups to associate with the Cluster"
}

variable "tags_rds_cluster" {
  type = map(string)
  default = null
}

#-------- DB Subnet Group --------

variable "subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group"
  default     = ""
}

variable "description" {
  type        = string
  description = "The description of the DB subnet group"
  default     = ""
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs"
}

variable "tags_db_subnet_group" {
  type = map(string)
  default = null
}

#-------- DB Subnet Group --------
variable "instance_class" {
  type = string
  description = "Instance class to use"
}

variable "tags_rds_cluster_instance" {
  type = map(string)
  default = null
}

variable "identifier" {
  type = string
  default = null
}