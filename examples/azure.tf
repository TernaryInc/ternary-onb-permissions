module "ternary" {
  source = "github.com/TernaryInc/ternary-onb-permissions//azure/terraform?ref=master"

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