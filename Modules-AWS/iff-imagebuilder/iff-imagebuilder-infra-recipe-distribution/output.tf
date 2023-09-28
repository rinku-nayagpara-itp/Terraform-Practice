output "infra_config_arn" {
  value = aws_imagebuilder_infrastructure_configuration.this[0].arn
}

output "recipe_arn" {
  value = aws_imagebuilder_image_recipe.this[0].arn
}

output "distribution_arn" {
  value = aws_imagebuilder_distribution_configuration.this[0].arn
}