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
