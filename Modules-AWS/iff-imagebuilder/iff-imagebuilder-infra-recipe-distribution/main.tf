resource "aws_imagebuilder_infrastructure_configuration" "this" {
  count                 = var.infra_config_name == null ? 0 : 1
  description           = var.description
  instance_profile_name = var.instance_profile
  instance_types        = var.instance_types
  name                  = var.infra_config_name
  security_group_ids    = var.security_group_ids
  sns_topic_arn         = var.sns_topic
  subnet_id             = var.subnet_id
  dynamic "logging" {
    for_each = var.logging == null ? {} : { 1 = 1 }
    content {
      s3_logs {
        s3_bucket_name = var.logging.s3_bucket_name
      }
    }
  }

  tags = var.infra_config_tags
}


# imagebuilder recipe

resource "aws_imagebuilder_image_recipe" "this" {
  count = var.image_recipe_name == null ? 0 : 1
  dynamic "block_device_mapping" {
    for_each = var.block_device_mapping
    content {
      device_name = try(block_device_mapping.value.device_name)
      dynamic "ebs" {
        for_each = block_device_mapping.value.ebs
        content {
          delete_on_termination = try(ebs_block_device.value.delete_on_termination, null)
          encrypted             = try(ebs_block_device.value.encrypted, null)
          iops                  = try(ebs_block_device.value.iops, null)
          kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
          snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
          volume_size           = try(ebs_block_device.value.volume_size, null)
          volume_type           = try(ebs_block_device.value.volume_type, null)
        }
      }
    }
  }

  dynamic "component" {
    for_each = var.component
    content {
      component_arn = component.value.component_arn
      dynamic "parameter" {
        for_each = component.value.parameter == null ? [] : component.value.parameter
        content {
          name  = parameter.value.name
          value = parameter.value.value
        }
      }
    }
  }

  name         = var.image_recipe_name
  parent_image = var.recipe_parent_image
  version      = var.recipe_version
  tags         = var.recipe_tags
}


# distribution config

resource "aws_imagebuilder_distribution_configuration" "this" {
  count = var.distribution_config_name == null ? 0 : 1
  name  = var.distribution_config_name
  dynamic "distribution" {
    for_each = var.distribution
    content {
      dynamic "ami_distribution_configuration" {
        for_each = distribution.value.ami_distribution_configuration
        content {
          target_account_ids = ami_distribution_configuration.value.target_account_ids
          name               = ami_distribution_configuration.value.name
          description        = ami_distribution_configuration.value.description
        }
      }
      region = distribution.value.region
    }
  }
  tags = var.distributiin_tags
}

