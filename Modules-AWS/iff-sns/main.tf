resource "aws_sns_topic" "sns_topic" {
    name            = var.sns_topic_name
    display_name    = var.display_name
    policy          = var.sns_access_policy
    delivery_policy = var.sns_delivery_policy
    tags            = var.tags
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
 for_each = var.sns_topic_subscription
 topic_arn = aws_sns_topic.sns_topic.arn
 protocol = each.value.protocol
 endpoint = each.value.endpoint
 }