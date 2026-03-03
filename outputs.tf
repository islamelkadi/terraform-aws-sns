# SNS Topic Module Outputs

output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.this.arn
}

output "topic_id" {
  description = "ID of the SNS topic"
  value       = aws_sns_topic.this.id
}

output "topic_name" {
  description = "Name of the SNS topic"
  value       = aws_sns_topic.this.name
}

output "topic_owner" {
  description = "AWS account ID of the topic owner"
  value       = aws_sns_topic.this.owner
}

output "subscription_arns" {
  description = "Map of subscription ARNs"
  value       = { for k, v in aws_sns_topic_subscription.this : k => v.arn }
}

output "tags" {
  description = "Tags applied to the SNS topic"
  value       = aws_sns_topic.this.tags
}
