variable "cluster_name" {
  description = "Name of the EMR cluster"
  type        = string
}

variable "release_label" {
  description = "Release label of the EMR cluster"
  type        = string
}

variable "log_uri" {
  description = "URI for EMR logs"
  type        = string
}

variable "visible_to_all_users" {
  description = "Whether the EMR cluster is visible to all users"
  type        = bool
}

variable "termination_protection" {
  description = "Whether termination protection is enabled for the EMR cluster"
  type        = bool
}

variable "scale_down_behavior" {
  description = "Scale down behavior for the EMR cluster"
  type        = string
}

variable "ebs_root_volume_size" {
  type = number
}

variable "applications" {
  description = "List of EMR applications"
  type        = list(string)
}

variable "tags" {
  type = map(string)
}

variable "master_instance_group" {
  type = object({
    instance_type  = string
    instance_count = optional(number)
    name           = optional(string)
    ebs_config = object({
      size                 = number
      type                 = string
      iops                 = optional(number)
      throughput           = optional(number)
      volumes_per_instance = optional(number)
    })
  })
}

variable "core_instance_group" {
  type = object({
    autoscaling_policy = optional(string)
    instance_type      = string
    instance_count     = optional(number)
    name               = optional(string)
    ebs_config = object({
      size                 = number
      type                 = string
      iops                 = optional(number)
      throughput           = optional(number)
      volumes_per_instance = optional(number)
    })
  })
}

variable "ec2_attributes" {
  type = object({
    key_name                          = optional(string)
    subnet_id                         = optional(string)
    instance_profile                  = string
    emr_managed_master_security_group = optional(string)
    emr_managed_slave_security_group  = optional(string)
    service_access_security_group     = optional(string)

  })
}

# variable "master_instance_name" {
#   description = "name of master instance"
#   type        = string
# }

# variable "core_instance_name" {
#   description = "name of core instance"
#   type        = string
# }


# variable "master_instance_ebs_type" {
#   description = "EBS type for the EMR master instance"
#   type        = string
# }

# variable "core_instance_count" {
#   description = "Number of core instances for the EMR cluster"
#   type        = number

# }

# variable "core_instance_type" {
#   description = "Instance type for the EMR core instances"
#   type        = string
# }

# variable "core_instance_ebs_size" {
#   description = "EBS size for the EMR core instances"
#   type        = number
# }

variable "service_role" {
  description = "Name of the service role for the EMR cluster"
  type        = string
}

variable "autoscaling_role" {
  description = "Name of the autoscaling role for the EMR cluster"
  type        = string
}

variable "security_configuration" {
  description = "Name of the security configuration for the EMR cluster"
  type        = string
}


variable "ssh_key_id" {
  description = "Name of the SSH key pair to use for EC2 instances"
  default     = "emrTest"
}
variable "region" {
  description = "primary region to build cluster in"
  type        = string
  default     = ""
}

#bootstrap 

variable "bootstrap_action" {
  description = "List of bootstrap actions for EMR cluster"
  type = list(object({
    name = string
    path = string
    args = list(string)
  }))
}

#task isntance group--------------
variable "instance_group_name" {
  description = "The EC2 instance group name for task instances in the EMR cluster"
  type        = string
}

variable "task_instance_type" {
  description = "The EC2 instance type for task instances in the EMR cluster"
  type        = string
}

variable "task_instance_count" {
  description = "The number of task instances in the EMR cluster"
  type        = number
}

# variable "task_instance_ebs_type" {
#   description = "The type of the EBS volume for task instances in the EMR cluster"
#   type        = string

# }

variable "instance_group_ebs_config" {
  type = object({
    size                 = number
    type                 = string
    iops                 = optional(number)
    throughput           = optional(number)
    volumes_per_instance = optional(number)
  })
}
