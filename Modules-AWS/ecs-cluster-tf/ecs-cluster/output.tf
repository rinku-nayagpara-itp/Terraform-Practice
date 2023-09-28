output "ecs_cluster_arn" {
  depends_on = [ aws_ecs_cluster.ecs_cluster ]
  value = var.name==null ? null : aws_ecs_cluster.ecs_cluster[0].arn 
}

output "task_definitions_arn" {
  value = [for idx, val in aws_ecs_task_definition.task_definition : val.arn]
}

output "cluster_name" {
  depends_on = [ aws_ecs_cluster.ecs_cluster ]
  value = var.name==null ? null : aws_ecs_cluster.ecs_cluster[0].name

}
