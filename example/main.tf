# Primary Module Example - This demonstrates the terraform-aws-sns module
# Supporting infrastructure (KMS, SQS) is defined in separate files
# to keep this example focused on the module's core functionality.

module "notifications" {
  source = "../"

  namespace    = var.namespace
  environment  = var.environment
  name         = var.name
  region       = var.region
  display_name = var.display_name

  # Subscription types
  email_subscriptions = [var.email_endpoint]
  
  # Direct reference to dlq.tf module output
  sqs_subscriptions = [module.sqs_queue.queue_arn]

  # Direct reference to kms.tf module output
  kms_key_arn = module.kms_key.key_arn

  tags = var.tags
}
