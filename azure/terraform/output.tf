output "module_version" {
  value = "0.1"
}

output "directory_id" {
  value = data.azuread_client_config.current.tenant_id
}

output "app_id" {
  value = azuread_application_registration.ternary.client_id
}

output "storage_account" {
  value = azurerm_storage_account.ternary.primary_blob_endpoint
}

output "storage_container" {
  value = azurerm_storage_container.ternary.name
}

output "actuals_path" {
  value = azurerm_billing_account_cost_management_export.actuals.export_data_storage_location[0].root_folder_path
}

output "amortized_path" {
  value = azurerm_billing_account_cost_management_export.amortized.export_data_storage_location[0].root_folder_path
}
