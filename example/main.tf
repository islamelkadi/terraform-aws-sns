module "notifications" {
  source = "../"

  namespace    = var.namespace
  environment  = var.environment
  name         = var.name
  region       = var.region
  display_name = var.display_name

  # Subscription types
  email_subscriptions = [var.email_endpoint]
  sqs_subscriptions   = [var.sqs_queue_arn]

  kms_key_arn = var.kms_key_arn

  tags = var.tags
}
