# SNS Topic Module Variables

# Metadata variables for consistent naming
variable "namespace" {
  description = "Namespace (organization/team name)"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod"
  }
}

variable "name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

# SNS specific variables
variable "display_name" {
  description = "Display name for the SNS topic"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption. If not provided, uses AWS managed key"
  type        = string
  default     = null
}

variable "delivery_policy" {
  description = "JSON-encoded delivery policy for the topic"
  type        = string
  default     = null
}

variable "fifo_topic" {
  description = "Whether the topic is a FIFO topic"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO topics"
  type        = bool
  default     = false
}

variable "topic_policy" {
  description = "JSON-encoded topic policy. If not provided, uses default policy"
  type        = string
  default     = null
}

# Subscription variables
variable "email_subscriptions" {
  description = "List of email addresses to subscribe to the topic"
  type        = list(string)
  default     = []
}

variable "sms_subscriptions" {
  description = "List of phone numbers to subscribe to the topic"
  type        = list(string)
  default     = []
}

variable "lambda_subscriptions" {
  description = "List of Lambda function ARNs to subscribe to the topic"
  type        = list(string)
  default     = []
}

variable "sqs_subscriptions" {
  description = "List of SQS queue ARNs to subscribe to the topic"
  type        = list(string)
  default     = []
}

variable "https_subscriptions" {
  description = "List of HTTPS endpoints to subscribe to the topic"
  type        = list(string)
  default     = []
}

# Security controls
variable "security_controls" {
  description = "Security controls configuration from metadata module"
  type = object({
    encryption = object({
      require_kms_customer_managed  = bool
      require_encryption_at_rest    = bool
      require_encryption_in_transit = bool
      enable_kms_key_rotation       = bool
    })
    logging = object({
      require_cloudwatch_logs = bool
      min_log_retention_days  = number
      require_access_logging  = bool
      require_flow_logs       = bool
    })
    monitoring = object({
      enable_xray_tracing         = bool
      enable_enhanced_monitoring  = bool
      enable_performance_insights = bool
      require_cloudtrail          = bool
    })
    compliance = object({
      enable_point_in_time_recovery = bool
      require_reserved_concurrency  = bool
      enable_deletion_protection    = bool
    })
  })
  default = null
}

variable "security_control_overrides" {
  description = "Override specific security controls with documented justification"
  type = object({
    disable_kms_requirement = optional(bool, false)
    justification           = optional(string, "")
  })
  default = {
    disable_kms_requirement = false
    justification           = ""
  }
}
