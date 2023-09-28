resource "aws_imagebuilder_component" "this" {
  for_each           = { for idx, val in var.components : idx => val }
  name               = each.value.name
  platform           = each.value.platform
  version            = each.value.version
  data               = each.value.data
  description        = each.value.description
  change_description = each.value.change_description
  tags               = each.value.tags
}


