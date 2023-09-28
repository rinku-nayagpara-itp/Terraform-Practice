output "cluster_id" {
  description = "ID of the EMR cluster"
  value       = aws_emr_cluster.cluster.id
}

output "emr_cluster_id" {
  value = aws_emr_cluster.cluster.id
}

output "emr_cluster_name" {
  value = aws_emr_cluster.cluster.name
}
