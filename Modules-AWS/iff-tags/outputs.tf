output "asg_tags" {
  //value       = ["${data.null_data_source.asg_tags.*.outputs}"]
  value       = local.asgtags
  description = "Tags as a list of maps for ASGs"
}

output "tags" {
  value = local.tags
}

