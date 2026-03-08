# Supporting Infrastructure - Real SQS resources for testing
# This infrastructure is created from remote GitHub modules to provide
# realistic SQS queue dependencies for the primary module example.
# 
# Available module outputs (reference directly in main.tf):
# - module.sqs_queue.queue_arn
# - module.sqs_queue.queue_url
#
# Example usage in main.tf:
#   sqs_subscriptions = [module.sqs_queue.queue_arn]

module "sqs_queue" {
  source = "git::https://github.com/islamelkadi/terraform-aws-sqs.git"

  namespace   = var.namespace
  environment = var.environment
  name        = "example-queue"
  region      = var.region

  # Direct reference to kms.tf module output
  kms_master_key_id = module.kms_key.key_id

  message_retention_seconds = 345600  # 4 days

  tags = {
    Purpose = "example-supporting-infrastructure"
  }
}
