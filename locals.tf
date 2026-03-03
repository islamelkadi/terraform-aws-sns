# Local values for SNS module

locals {
  # Topic name with FIFO suffix if applicable
  topic_name = var.fifo_topic ? "${module.metadata.resource_prefix}.fifo" : module.metadata.resource_prefix

  # Convert legacy subscription variables to new format for backward compatibility
  legacy_email_subscriptions = [
    for email in var.email_subscriptions : {
      protocol             = "email"
      endpoint             = email
      filter_policy        = null
      raw_message_delivery = false
      redrive_policy       = null
      delivery_policy      = null
    }
  ]

  legacy_sms_subscriptions = [
    for phone in var.sms_subscriptions : {
      protocol             = "sms"
      endpoint             = phone
      filter_policy        = null
      raw_message_delivery = false
      redrive_policy       = null
      delivery_policy      = null
    }
  ]

  legacy_lambda_subscriptions = [
    for arn in var.lambda_subscriptions : {
      protocol             = "lambda"
      endpoint             = arn
      filter_policy        = null
      raw_message_delivery = false
      redrive_policy       = null
      delivery_policy      = null
    }
  ]

  legacy_sqs_subscriptions = [
    for arn in var.sqs_subscriptions : {
      protocol             = "sqs"
      endpoint             = arn
      filter_policy        = null
      raw_message_delivery = false
      redrive_policy       = null
      delivery_policy      = null
    }
  ]

  legacy_https_subscriptions = [
    for url in var.https_subscriptions : {
      protocol             = "https"
      endpoint             = url
      filter_policy        = null
      raw_message_delivery = false
      redrive_policy       = null
      delivery_policy      = null
    }
  ]

  # Combine legacy subscriptions (new subscriptions variable not yet implemented)
  all_subscriptions = concat(
    local.legacy_email_subscriptions,
    local.legacy_sms_subscriptions,
    local.legacy_lambda_subscriptions,
    local.legacy_sqs_subscriptions,
    local.legacy_https_subscriptions
  )

  # Merged tags
  tags = merge(
    var.tags,
    module.metadata.security_tags,
    {
      Module = "terraform-aws-sns"
    }
  )
}
