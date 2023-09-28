resource "aws_batch_compute_environment" "this" {
  compute_environment_name = var.compute_environment_name
  type                     = var.type
  dynamic "compute_resources" {
    for_each = var.compute_resources != null ? [var.compute_resources] : []
    content {
      instance_role       = try(compute_resources.value.instance_role, null)
      allocation_strategy = try(compute_resources.value.allocation_strategy, null)
      instance_type       = try(compute_resources.value.instance_type, null)
      dynamic "launch_template" {
        for_each = compute_resources.value.launch_template == null ? [] : [compute_resources.value.launch_template]
        content {
          launch_template_id = launch_template.value.launch_template_id
          version            = launch_template.value.version
        }
      }
      dynamic "ec2_configuration" {
        for_each = compute_resources.value.ec2_configuration == null ? [] : compute_resources.value.ec2_configuration
        content {
          image_type = ec2_configuration.value.image_type
        }
      }
      desired_vcpus      = compute_resources.value.desired_vcpus
      min_vcpus          = compute_resources.value.min_vcpus
      max_vcpus          = compute_resources.value.max_vcpus
      security_group_ids = compute_resources.value.security_group_ids
      subnets            = compute_resources.value.subnets
      type               = compute_resources.value.type
      tags               = compute_resources.value.tags
    }
  }
  service_role = var.service_role
}
