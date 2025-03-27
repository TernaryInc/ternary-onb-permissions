# GCP Permissions Module

This module provides two deployment options:

1. A Terraform module
2. A YAML configuration file (`role.yaml`)

## Prerequisites

Before using this module, you need to set up a billing export in Google Cloud Console:

1. Follow these [instructions] to create your billing export
2. Note the project and dataset where you configured the export
3. Ensure both detailed and standard billing exports are sent to the same location

## Usage

- For Terraform usage, see [this example](../../examples/gcp.tf)
- For YAML configuration, apply the `role.yaml` file using the Google Cloud Console

## Output

This module creates the necessary IAM permissions for Ternary's service account to access:

- Your billing export
- Billing account information
- Required API endpoints

[instructions]: https://cloud.google.com/billing/docs/how-to/export-data-bigquery-setup
