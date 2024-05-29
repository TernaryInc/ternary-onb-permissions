# Terraform module for Ternary Azure onboarding

This terraform module will help you follow the steps described
in our knowledge base for Azure onboarding.

## Example usage

```
module "ternary" {
  source = "https://github.com/TernaryInc/ternary-onb-permissions.git//azure/terraform?ref=master"

  billing_account_id      = "MY_MICROSOFT_BILLING_ACCOUNT_ID"
  client_certificate_path = "/path/to/your/Ternary_Azure.pem"
  enhanced_access_scopes = [
  "/providers/Microsoft.Management/managementGroups/MY-ROOT-MANAGEMENT-GROUP-GUID"
  ]
}

output "ternary_directory_id" { value = module.ternary.directory_id }
output "ternary_app_id" { value = module.ternary.app_id }
output "ternary_storage_account" { value = module.ternary.storage_account }
output "ternary_storage_container" { value = module.ternary.storage_container }
output "ternary_actuals_path" { value = module.ternary.actuals_path }
output "ternary_amortized_path" { value = module.ternary.amortized_path }

provider "azuread" {
  tenant_id = "my-active-directory-tenant-id"
}

provider "azurerm" {
  features {}
}
```

## Future work

* Automatically backfill the created billing exports for the maximum account of time when the export is created for the first time.
