variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = ""
}

variable "cpu_core_count" {
  description = "Number of CPU cores for the EC2 instance"
  type        = number
  default     = 1
}

variable "cpu_threads_per_core" {
  description = "Number of CPU threads per core for the EC2 instance"
  type        = number
  default     = 1
}

variable "hibernation" {
  description = "Enable hibernation for the EC2 instance"
  type        = bool
  default = false
}

variable "user_data" {
  type    = string
  default = null
}

variable "user_data_base64" {
  type    = string
  default = null
}

variable "user_data_replace_on_change" {
  type    = bool
  default = null
}

variable "availability_zone" {
  type    = string
  default = null
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "key_name" {
  type        = string
  default     = null
  description = "The name of the key pair to associate with the instance"
}

variable "monitoring" {
  type        = bool
  default     = null
  description = "Enable detailed monitoring for the instance"
}

variable "get_password_data" {
  type        = bool
  default     = null
  description = "Retrieve the generated password data for Windows instances"
}

variable "iam_instance_profile" {
  type        = string
  default     = null
  description = "The IAM instance profile to associate with the instance"
}

variable "associate_public_ip_address" {
  type        = bool
  default     = null
  description = "Associate a public IP address with the instance"
}

variable "private_ip" {
  type        = string
  default     = null
  description = "The private IP address to assign to the instance"
}

variable "secondary_private_ips" {
  type        = list(string)
  default     = null
  description = "A list of secondary private IP addresses to assign to the instance"
}

variable "ipv6_address_count" {
  type        = number
  default     = null
  description = "The number of IPv6 addresses to associate with the instance"
}

variable "ipv6_addresses" {
  type        = list(string)
  default     = null
  description = "A list of IPv6 addresses to associate with the instance"
}

variable "ebs_optimized" {
  type        = bool
  default     = null
  description = "Enable EBS optimization for the instance"
}


variable "vpc_security_group_ids" {
  type    = list(string)
  default = null
}

variable "cpu_options" {
  type = list(object({
    core_count       = optional(number)
    threads_per_core = optional(number)
    amd_sev_snp      = optional(string)
  }))
  default = [{
    core_count       = 1
    threads_per_core = 2
    amd_sev_snp      = "disabled"
  }]
}

variable "root_block_device" {
  type = list(object({
    delete_on_termination = optional(bool)
    encrypted             = optional(bool)
    iops                  = optional(number)
    kms_key_id            = optional(string)
    volume_size           = optional(number)
    volume_type           = optional(string)
    throughput            = optional(number)
    tags                  = optional(map(string))
  }))
  default     = []
  description = "Root block device configuration for the instance"
}

variable "ebs_block_device" {
  type = list(object({
    delete_on_termination = optional(bool)
    device_name           = optional(string)
    encrypted             = optional(bool)
    iops                  = optional(number)
    kms_key_id            = optional(string)
    snapshot_id           = optional(string)
    volume_size           = optional(number)
    volume_type           = optional(string)
    throughput            = optional(number)
    tags                  = optional(map(string))
  }))
  default     = []
  description = "EBS block device configuration for the instance"
}

variable "ephemeral_block_device" {
  type = list(object({
    device_name  = string
    no_device    = optional(bool)
    virtual_name = optional(string)
  }))
  default     = []
  description = "Ephemeral block device configuration for the instance"
}

variable "network_interface" {
  type = list(object({
    device_index          = number
    network_interface_id  = string
    delete_on_termination = optional(bool)
  }))
  default     = []
  description = "Network interface configuration for the instance"
}

variable "source_dest_check" {
  type        = bool
  default     = true
  description = "Indicates whether source/destination checking is enabled. Set to false if the instance is in a VPC with an attached network interface."
}

variable "disable_api_termination" {
  type        = bool
  default     = false
  description = "Indicates whether the instance can be terminated using the EC2 API."
}

variable "disable_api_stop" {
  type        = bool
  default     = false
  description = "Indicates whether the instance can be stopped using the EC2 API."
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  default     = "stop"
  description = "Indicates whether the instance stops or terminates when it is shut down."
}

variable "placement_group" {
  type        = string
  default     = null
  description = "The name of the placement group the instance is launched in."
}

variable "tenancy" {
  type        = string
  default     = null
  description = "The tenancy of the instance (default, dedicated, or host)."
}

variable "host_id" {
  type        = string
  default     = null
  description = "The ID of the Dedicated Host on which the instance resides."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the instance."
}

variable "volume_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the root volume of the instance."
}
