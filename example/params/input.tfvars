# SNS Module Example Input Variables

namespace   = "example"
environment = "dev"
name        = "notifications"
region      = "us-east-1"

display_name = "Application Notifications"

# KMS key ARN for encryption (replace with your KMS key ARN)
kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

# Email endpoint for notifications
email_endpoint = "notifications@example.com"

# SQS queue ARN for notifications (replace with your SQS queue ARN)
sqs_queue_arn = "arn:aws:sqs:us-east-1:123456789012:notifications-queue"

tags = {
  Purpose = "NOTIFICATIONS"
  Team    = "PLATFORM"
}
