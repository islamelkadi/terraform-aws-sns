# SNS Module Example Outputs

output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = module.notifications.topic_arn
}

output "topic_name" {
  description = "Name of the SNS topic"
  value       = module.notifications.topic_name
}

output "subscription_arns" {
  description = "Map of subscription ARNs"
  value       = module.notifications.subscription_arns
}
