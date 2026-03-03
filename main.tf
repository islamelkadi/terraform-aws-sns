# SNS Topic Module
# Creates AWS SNS topic with encryption and subscriptions

resource "aws_sns_topic" "this" {
  name              = local.topic_name
  display_name      = var.display_name
  kms_master_key_id = var.kms_key_arn

  # Delivery policy for retries
  delivery_policy = var.delivery_policy

  # FIFO configuration
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication

  tags = local.tags
}

# SNS Topic Policy
resource "aws_sns_topic_policy" "this" {
  count = var.topic_policy != null ? 1 : 0

  arn    = aws_sns_topic.this.arn
  policy = var.topic_policy
}

# Dynamic Subscriptions
resource "aws_sns_topic_subscription" "this" {
  for_each = { for idx, sub in local.all_subscriptions : idx => sub }

  topic_arn = aws_sns_topic.this.arn
  protocol  = each.value.protocol
  endpoint  = each.value.endpoint

  # Optional attributes
  filter_policy        = each.value.filter_policy
  raw_message_delivery = each.value.raw_message_delivery
  redrive_policy       = each.value.redrive_policy
  delivery_policy      = each.value.delivery_policy
}
