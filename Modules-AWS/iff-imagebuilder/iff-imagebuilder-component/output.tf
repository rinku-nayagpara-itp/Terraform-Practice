output "arn" {
  value = [for idx, val in aws_imagebuilder_component.this : val.arn]
}
