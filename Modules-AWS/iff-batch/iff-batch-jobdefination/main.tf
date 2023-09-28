resource "aws_batch_job_definition" "this" {
  name                 = var.name
  type                 = var.type
  container_properties = var.container_properties
  dynamic "retry_strategy" {
    for_each = var.retry_strategy == null ? [] : [var.retry_strategy]
    content {
      attempts = retry_strategy.value.attempts
    }
  }
  platform_capabilities = var.platform_capabilities
  tags                  = var.tags
}
