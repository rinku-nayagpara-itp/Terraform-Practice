resource "aws_launch_template" "this" {
  name_prefix             = var.template_name_prefix
  description             = var.description
  ebs_optimized           = var.ebs_optimized
  image_id                = var.image_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  user_data               = var.user_data
  vpc_security_group_ids  = var.vpc_security_group_ids
  default_version         = var.launch_template_default_version
  disable_api_termination = var.disable_api_termination

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings == null ? [] : var.block_device_mappings
    content {
      device_name  = block_device_mappings.value.device_name
      no_device    = block_device_mappings.value.no_device
      virtual_name = block_device_mappings.value.virtual_name

      dynamic "ebs" {
        for_each = block_device_mappings.value.ebs == null? [] : block_device_mappings.value.ebs
        content {
          delete_on_termination = ebs.value.delete_on_termination
          encrypted             = ebs.value.encrypted
          kms_key_id            = ebs.value.kms_key_id
          iops                  = ebs.value.iops
          throughput            = ebs.value.throughput
          snapshot_id           = ebs.value.snapshot_id
          volume_size           = ebs.value.volume_size
          volume_type           = ebs.value.volume_type
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = var.cpu_options != null ? [var.cpu_options] : []
    content {
      core_count       = cpu_options.value.core_count
      threads_per_core = cpu_options.value.threads_per_core
    }
  }

  dynamic "credit_specification" {
    for_each = var.credit_specification != null ? [var.credit_specification] : []
    content {
      cpu_credits = credit_specification.value.cpu_credits
    }
  }

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile != null ? [var.iam_instance_profile] : []
    content {
      name = var.iam_instance_profile.name
      arn  = var.iam_instance_profile.arn
    }
  }

  dynamic "monitoring" {
    for_each = var.enable_monitoring != null ? [1] : []
    content {
      enabled = var.enable_monitoring
    }
  }
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  dynamic "network_interfaces" {
    for_each = var.network_interfaces != null ? var.network_interfaces : []
    content {
      associate_carrier_ip_address = network_interfaces.value.associate_carrier_ip_address
      associate_public_ip_address  = network_interfaces.value.associate_public_ip_address
      delete_on_termination        = network_interfaces.value.delete_on_termination
      description                  = network_interfaces.value.description
      device_index                 = network_interfaces.value.device_index
      interface_type               = network_interfaces.value.interface_type
      ipv4_addresses               = network_interfaces.value.ipv4_addresses
      ipv6_addresses               = network_interfaces.value.ipv6_addresses
      network_interface_id         = network_interfaces.value.network_interface_id
      private_ip_address           = network_interfaces.value.private_ip_address
      security_groups              = network_interfaces.value.security_groups
      subnet_id                    = network_interfaces.value.subnet_id
    }
  }

  dynamic "tag_specifications" {
    for_each = var.tag_specifications == null ? []:var.tag_specifications
    content {
      resource_type = tag_specifications.value.resource_type
      tags          = tag_specifications.value.tags
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}