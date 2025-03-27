# Payer Account Module

This module provides two deployment options:

1. A Terraform module
2. A CloudFormation template (`ternary-payer-account-cfn.json`)

## Prerequisites

- `ternary_service_account_email` and `ternary_service_account_uid` from your Ternary Admin page
- `ternary_bucket_id` from your AWS CUR export S3 bucket setup

## Usage

- For Terraform usage, see [this example](../../examples/aws_payer-monitoring.tf)
- For CloudFormation, upload the template through the AWS console

## Output

Both deployment methods create a `TernaryCMPServiceAgent` role. Copy this role's ARN into the "Role ARN" field in your Ternary configuration.
