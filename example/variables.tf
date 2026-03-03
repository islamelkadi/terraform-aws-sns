# SNS Module Example Variables

variable "namespace" {
  description = "Namespace (organization/team name)"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "display_name" {
  description = "Display name for the SNS topic"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
}

variable "email_endpoint" {
  description = "Email address for notifications"
  type        = string
}

variable "sqs_queue_arn" {
  description = "ARN of SQS queue for notifications"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
