# SNS Module Example

This example demonstrates how to use the SNS module with dynamic subscriptions.

## Features Demonstrated

- Email subscription
- SQS subscription with filter policy
- Raw message delivery
- KMS encryption
- Dynamic subscriptions list

## Usage

1. Update `params/input.tfvars` with your values:
   - Replace `kms_key_arn` with your KMS key ARN
   - Replace `sqs_queue_arn` with your SQS queue ARN
   - Update `email_endpoint` if desired

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Plan the deployment:
   ```bash
   terraform plan -var-file=params/input.tfvars
   ```

4. Apply the configuration:
   ```bash
   terraform apply -var-file=params/input.tfvars
   ```

## Prerequisites

- AWS KMS key for encryption
- SQS queue for message delivery
- Valid email address for notifications

## Outputs

- `topic_arn` - ARN of the created SNS topic
- `topic_name` - Name of the SNS topic
- `subscription_arns` - Map of subscription ARNs by index

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.34 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms_key"></a> [kms\_key](#module\_kms\_key) | git::https://github.com/islamelkadi/terraform-aws-kms.git | v1.0.0 |
| <a name="module_notifications"></a> [notifications](#module\_notifications) | ../ | n/a |
| <a name="module_sqs_queue"></a> [sqs\_queue](#module\_sqs\_queue) | git::https://github.com/islamelkadi/terraform-aws-sqs.git | v1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name for the SNS topic | `string` | `""` | no |
| <a name="input_email_endpoint"></a> [email\_endpoint](#input\_email\_endpoint) | Email address for notifications | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the SNS topic | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (organization/team name) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subscription_arns"></a> [subscription\_arns](#output\_subscription\_arns) | Map of subscription ARNs |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | ARN of the SNS topic |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | Name of the SNS topic |
<!-- END_TF_DOCS -->
