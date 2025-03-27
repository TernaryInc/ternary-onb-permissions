# Linked Account Module

This module provides two deployment options:

1. A Terraform module
2. A CloudFormation template (`ternary-linked-account-cfn.json`)

## Prerequisites

- `ternary_service_account_email` and `ternary_service_account_uid` from your Ternary Admin page

## Usage

- For Terraform usage, see [this example](../../examples/aws_linked-account.tf)
- For CloudFormation, upload the template through the AWS console

## Important Notes

1. This module creates a `TernaryCMPLinkedAccountAgent` role in each linked AWS account where you want to gather metrics
2. You must repeat these steps for all linked accounts you wish to connect to Ternary
3. After deployment, provide all role ARNs to your Success Team

## Related Resources

- [aws-centralized-monitoring]: Repository for centralized AWS monitoring setup
