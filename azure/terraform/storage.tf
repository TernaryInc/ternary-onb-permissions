resource "azurerm_storage_account" "ternary" {
  name                     = "ternary${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.ternary.name
  location                 = azurerm_resource_group.ternary.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_string" "suffix" {
  length  = 16
  special = false
  upper   = false
}

resource "azurerm_storage_container" "ternary" {
  name                 = "billexports"
  storage_account_name = azurerm_storage_account.ternary.name
}


resource "azurerm_role_assignment" "ternary_storage_reader" {
  scope                = azurerm_storage_container.ternary.resource_manager_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azuread_service_principal.ternary.id
  principal_type       = "ServicePrincipal"

}
