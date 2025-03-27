# Azure Onboarding Module

This Terraform module automates the Azure onboarding process for Ternary. It implements the steps described in our knowledge base for Azure integration.

## Usage

See [this example](../../examples/azure.tf) for how to use this module in your Terraform configuration.

## Features

- Creates necessary Azure resources for Ternary integration
- Sets up billing exports and required permissions
- Configures storage accounts and application registrations

## Future Enhancements

- Automatic backfilling of billing exports for the maximum available time period when creating new exports
