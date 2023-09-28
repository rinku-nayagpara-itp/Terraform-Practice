resource "aws_ecs_service" "ecs_service" {
  name                               = var.name
  cluster                            = var.cluster
  task_definition                    = var.task_definition
  desired_count                      = var.desired_count
  launch_type                        = var.launch_type
  platform_version                   = var.platform_version
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  
  network_configuration {
    subnets         = var.network_configuration.subnets
    security_groups = var.network_configuration.security_groups
  }

  load_balancer {
    target_group_arn = var.load_balancer.target_group_arn
    container_name   = var.load_balancer.container_name
    container_port   = var.load_balancer.container_port
  }
  tags = var.tags
}
