# Terraform AWS SNS Module

A reusable Terraform module for creating AWS SNS topics with subscriptions, encryption, and delivery policies.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Security Controls](#security-controls)
- [Features](#features)
- [Usage Examples](#usage-examples)
- [Requirements](#requirements)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Examples](#examples)

---

## Prerequisites

This module is designed for macOS. The following must already be installed on your machine:
- Python 3 and pip
- [Kiro](https://kiro.dev) and Kiro CLI
- [Homebrew](https://brew.sh)

To install the remaining development tools, run:

```bash
make bootstrap
```

This will install/upgrade: tfenv, Terraform (via tfenv), tflint, terraform-docs, checkov, and pre-commit.

## Security Controls

This module implements security controls to comply with:
- AWS Foundational Security Best Practices (FSBP)
- CIS AWS Foundations Benchmark
- NIST 800-53 Rev 5
- NIST 800-171 Rev 2
- PCI DSS v4.0

### Implemented Controls

- [x] **Encryption**: KMS encryption at rest with customer-managed keys
- [x] **Encryption in Transit**: TLS 1.2+ for all message delivery
- [x] **Access Control**: IAM policies for topic access management
- [x] **Security Control Overrides**: Extensible override system with audit justification
- [ ] **Delivery Status Logging**: CloudWatch Logs for delivery failures (planned feature)

### Security Best Practices

**Production Topics:**
- Use KMS customer-managed keys for encryption
- Enable delivery status logging for critical topics
- Use IAM policies to restrict topic access
- Configure dead letter queues for failed deliveries
- Monitor delivery metrics in CloudWatch

**Development Topics:**
- KMS encryption still recommended
- Delivery logging optional for cost savings

For complete security standards and implementation details, see [AWS Security Standards](../../../.kiro/steering/aws/aws-security-standards.md).

## Features

- SNS topic with KMS encryption
- Multiple subscription types (Email, SMS, Lambda, SQS, HTTPS)
- FIFO topic support
- Custom delivery policies
- Security controls integration

## Usage Examples

### Basic Example

```hcl
module "sns_topic" {
  source = "github.com/islamelkadi/terraform-aws-sns?ref=v1.0.0"
  
  namespace   = "example"
  environment = "prod"
  name        = "alerts"
  region      = "us-east-1"
  
  display_name = "Corporate Actions Alerts"
  
  kms_key_arn = module.kms.key_arn
  
  email_subscriptions = [
    "ops-team@example.com"
  ]
  
  lambda_subscriptions = [
    module.alert_processor.function_arn
  ]
  
  tags = {
    Project = "CorporateActions"
  }
}
```

### Production Topic with Multiple Subscriptions

```hcl
module "sns_topic" {
  source = "github.com/islamelkadi/terraform-aws-sns?ref=v1.0.0"
  
  security_controls = module.metadata.security_controls
  
  namespace   = "example"
  environment = "prod"
  name        = "corporate-actions-events"
  region      = "us-east-1"
  
  display_name = "Corporate Actions Events"
  
  kms_key_arn = module.kms.key_arn
  
  # Multiple subscription types
  email_subscriptions = [
    "ops-team@example.com",
    "compliance@example.com"
  ]
  
  lambda_subscriptions = [
    module.event_processor.function_arn,
    module.audit_logger.function_arn
  ]
  
  sqs_subscriptions = [
    module.event_queue.queue_arn
  ]
  
  # Custom delivery policy
  delivery_policy = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget     = 20
        maxDelayTarget     = 20
        numRetries         = 3
        numMaxDelayRetries = 0
        numNoDelayRetries  = 0
        numMinDelayRetries = 0
        backoffFunction    = "linear"
      }
    }
  })
  
  tags = {
    Project    = "CorporateActions"
    Purpose    = "EventNotification"
    Compliance = "PCI-DSS"
  }
}
```

### FIFO Topic for Ordered Messages

```hcl
module "fifo_topic" {
  source = "github.com/islamelkadi/terraform-aws-sns?ref=v1.0.0"
  
  security_controls = module.metadata.security_controls
  
  namespace   = "example"
  environment = "prod"
  name        = "ordered-events"
  region      = "us-east-1"
  
  # FIFO configuration
  fifo_topic                  = true
  content_based_deduplication = true
  
  kms_key_arn = module.kms.key_arn
  
  # FIFO topics can only subscribe to FIFO SQS queues
  sqs_subscriptions = [
    module.fifo_queue.queue_arn
  ]
  
  tags = {
    Project = "CorporateActions"
    Type    = "FIFO"
  }
}
```

## Environment-Based Security Controls

Security controls are automatically applied based on the environment through the [terraform-aws-metadata](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles){:target="_blank"} module's security profiles:

| Control | Dev | Staging | Prod |
|---------|-----|---------|------|
| KMS encryption | Optional | Required | Required |
| Encryption in transit (TLS 1.2+) | Required | Required | Required |
| Access control (IAM) | Enforced | Enforced | Enforced |
| Dead letter queue | Optional | Recommended | Required |

For full details on security profiles and how controls vary by environment, see the <a href="https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles" target="_blank">Security Profiles</a> documentation.

## MCP Servers

This module includes two [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) servers configured in `.kiro/settings/mcp.json` for use with Kiro:

| Server | Package | Description |
|--------|---------|-------------|
| `aws-docs` | `awslabs.aws-documentation-mcp-server@latest` | Provides access to AWS documentation for contextual lookups of service features, API references, and best practices. |
| `terraform` | `awslabs.terraform-mcp-server@latest` | Enables Terraform operations (init, validate, plan, fmt, tflint) directly from the IDE with auto-approved commands for common workflows. |

Both servers run via `uvx` and require no additional installation beyond the [bootstrap](#prerequisites) step.

<!-- BEGIN_TF_DOCS -->


## Usage

```hcl
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.34 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.34 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metadata"></a> [metadata](#module\_metadata) | github.com/islamelkadi/terraform-aws-metadata | v1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes for naming | `list(string)` | `[]` | no |
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Enable content-based deduplication for FIFO topics | `bool` | `false` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to use between name components | `string` | `"-"` | no |
| <a name="input_delivery_policy"></a> [delivery\_policy](#input\_delivery\_policy) | JSON-encoded delivery policy for the topic | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name for the SNS topic | `string` | `""` | no |
| <a name="input_email_subscriptions"></a> [email\_subscriptions](#input\_email\_subscriptions) | List of email addresses to subscribe to the topic | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_fifo_topic"></a> [fifo\_topic](#input\_fifo\_topic) | Whether the topic is a FIFO topic | `bool` | `false` | no |
| <a name="input_https_subscriptions"></a> [https\_subscriptions](#input\_https\_subscriptions) | List of HTTPS endpoints to subscribe to the topic | `list(string)` | `[]` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of KMS key for encryption. If not provided, uses AWS managed key | `string` | `null` | no |
| <a name="input_lambda_subscriptions"></a> [lambda\_subscriptions](#input\_lambda\_subscriptions) | List of Lambda function ARNs to subscribe to the topic | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the SNS topic | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (organization/team name) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources will be created | `string` | n/a | yes |
| <a name="input_security_control_overrides"></a> [security\_control\_overrides](#input\_security\_control\_overrides) | Override specific security controls with documented justification | <pre>object({<br/>    disable_kms_requirement = optional(bool, false)<br/>    justification           = optional(string, "")<br/>  })</pre> | <pre>{<br/>  "disable_kms_requirement": false,<br/>  "justification": ""<br/>}</pre> | no |
| <a name="input_security_controls"></a> [security\_controls](#input\_security\_controls) | Security controls configuration from metadata module | <pre>object({<br/>    encryption = object({<br/>      require_kms_customer_managed  = bool<br/>      require_encryption_at_rest    = bool<br/>      require_encryption_in_transit = bool<br/>      enable_kms_key_rotation       = bool<br/>    })<br/>    logging = object({<br/>      require_cloudwatch_logs = bool<br/>      min_log_retention_days  = number<br/>      require_access_logging  = bool<br/>      require_flow_logs       = bool<br/>    })<br/>    monitoring = object({<br/>      enable_xray_tracing         = bool<br/>      enable_enhanced_monitoring  = bool<br/>      enable_performance_insights = bool<br/>      require_cloudtrail          = bool<br/>    })<br/>    compliance = object({<br/>      enable_point_in_time_recovery = bool<br/>      require_reserved_concurrency  = bool<br/>      enable_deletion_protection    = bool<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_sms_subscriptions"></a> [sms\_subscriptions](#input\_sms\_subscriptions) | List of phone numbers to subscribe to the topic | `list(string)` | `[]` | no |
| <a name="input_sqs_subscriptions"></a> [sqs\_subscriptions](#input\_sqs\_subscriptions) | List of SQS queue ARNs to subscribe to the topic | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_topic_policy"></a> [topic\_policy](#input\_topic\_policy) | JSON-encoded topic policy. If not provided, uses default policy | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subscription_arns"></a> [subscription\_arns](#output\_subscription\_arns) | Map of subscription ARNs |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags applied to the SNS topic |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | ARN of the SNS topic |
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | ID of the SNS topic |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | Name of the SNS topic |
| <a name="output_topic_owner"></a> [topic\_owner](#output\_topic\_owner) | AWS account ID of the topic owner |

## Example

See [example/](example/) for a complete working example with all features.

## License

MIT Licensed. See [LICENSE](LICENSE) for full details.
<!-- END_TF_DOCS -->

## Examples

See [example/](example/) for a complete working example with all features.

