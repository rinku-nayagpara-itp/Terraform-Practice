resource "aws_ecs_cluster" "ecs_cluster" {
  count = var.name==null ? 0:1
  name = var.name
  dynamic "setting" {
    for_each = { for key, value in var.cluster_setting : key => value }
    content {
      name = setting.value.name
      value = setting.value.value
    }
  }
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "log_group" {
  count = var.cloudwatch_log_group_name == null ? 0:1
  name              = var.cloudwatch_log_group_name
  retention_in_days = var.log_retention_days
}

resource "aws_ecs_cluster_capacity_providers" "capacity_providers" {
  count = var.capacity_providers == null? 0:1
  cluster_name       = aws_ecs_cluster.ecs_cluster[0].name

  capacity_providers = var.capacity_providers
  dynamic "default_capacity_provider_strategy" {
    for_each = { for key, value in var.default_capacity_provider : key => value }
    content {
      capacity_provider = default_capacity_provider_strategy.value.capacity_provider
      weight            = default_capacity_provider_strategy.value.weight
    }
  }
}

# ecs task definition
resource "aws_ecs_task_definition" "task_definition" {
  for_each                 = { for idx, value in var.ecs_task_definition : idx => value }
  family                   = each.value.family
  requires_compatibilities = each.value.requires_compatibilities
  cpu                      = each.value.cpu
  network_mode             = each.value.network_mode
  memory                   = each.value.memory
  container_definitions    = each.value.container_definition
  execution_role_arn       = each.value.execution_role_arn
  task_role_arn            = each.value.task_role_arn
  tags                     = each.value.task_tags
}
