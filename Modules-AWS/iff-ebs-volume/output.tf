output "arn" {
 value =  aws_ebs_volume.ebs.arn
}

output "ebs_volume_id" {
  value = aws_ebs_volume.ebs.id
}