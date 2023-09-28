resource "aws_emr_cluster" "cluster" {
  name                   = var.cluster_name
  release_label          = var.release_label
  log_uri                = var.log_uri
  visible_to_all_users   = var.visible_to_all_users
  termination_protection = var.termination_protection
  scale_down_behavior    = var.scale_down_behavior

  ebs_root_volume_size = var.ebs_root_volume_size
  applications         = var.applications
  tags = var.tags


  dynamic "bootstrap_action" {
    for_each = var.bootstrap_action
    content {
      name = bootstrap_action.value.name
      path = bootstrap_action.value.path
      args = bootstrap_action.value.args
    }
  }

  master_instance_group {
    instance_type  = var.master_instance_group.instance_type
    instance_count = var.master_instance_group.instance_count
    name           = var.master_instance_group.name

    ebs_config {
      size                 = var.master_instance_group.ebs_config.size
      type                 = var.master_instance_group.ebs_config.type
      iops                 = var.master_instance_group.ebs_config.iops
      throughput           = var.master_instance_group.ebs_config.throughput
      volumes_per_instance = var.master_instance_group.ebs_config.volumes_per_instance
    }
  }

  core_instance_group {
    autoscaling_policy = var.core_instance_group.autoscaling_policy
    instance_type      = var.core_instance_group.instance_type
    instance_count     = var.core_instance_group.instance_count
    name               = var.core_instance_group.name

    ebs_config {
      size                 = var.core_instance_group.ebs_config.size
      type                 = var.core_instance_group.ebs_config.type
      volumes_per_instance = var.core_instance_group.ebs_config.volumes_per_instance
      iops                 = var.core_instance_group.ebs_config.iops
      throughput           = var.core_instance_group.ebs_config.throughput
    }
  }

  ec2_attributes {
    key_name                          = var.ec2_attributes.key_name
    subnet_id                         = var.ec2_attributes.subnet_id
    instance_profile                  = var.ec2_attributes.instance_profile
    emr_managed_master_security_group = var.ec2_attributes.emr_managed_master_security_group
    emr_managed_slave_security_group  = var.ec2_attributes.emr_managed_slave_security_group
    service_access_security_group     = var.ec2_attributes.service_access_security_group
  }
  service_role           = var.service_role
  autoscaling_role       = var.autoscaling_role
  security_configuration = var.security_configuration
}


resource "aws_emr_instance_group" "task_instance_group" {
  name           = var.instance_group_name
  cluster_id     = aws_emr_cluster.cluster.id
  instance_type  = var.task_instance_type
  instance_count = var.task_instance_count

  ebs_config {
    size                 = var.instance_group_ebs_config.size
    type                 = var.instance_group_ebs_config.type
    volumes_per_instance = var.instance_group_ebs_config.volumes_per_instance
    iops                 = var.instance_group_ebs_config.iops
  }
}
