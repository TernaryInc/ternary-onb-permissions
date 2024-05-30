resource "azurerm_role_assignment" "advisor_reader" {
  for_each             = toset(var.enhanced_access_scopes)
  scope                = each.key
  role_definition_name = "Advisor Reviews Reader"
  principal_id         = azuread_service_principal.ternary.id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "monitoring_reader" {
  for_each             = toset(var.enhanced_access_scopes)
  scope                = each.key
  role_definition_name = "Monitoring Reader"
  principal_id         = azuread_service_principal.ternary.id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "cost_management_reader" {
  for_each             = toset(var.enhanced_access_scopes)
  scope                = each.key
  role_definition_name = "Cost Management Reader"
  principal_id         = azuread_service_principal.ternary.id
  principal_type       = "ServicePrincipal"
}

# azurerm is not capable of this granting the App access to the billing account
# https://learn.microsoft.com/en-us/answers/questions/1464207/cannot-assign-reservations-reader-permission-to-a

data "azurerm_role_definition" "reservations_reader" {
  name = "Reservations Reader"
}

resource "random_uuid" "reservations_reader_uuid" {}

resource "azapi_resource" "reservations_reader" {
  name      = random_uuid.reservations_reader_uuid.result
  type      = "Microsoft.Authorization/roleAssignments@2022-04-01"
  parent_id = "/providers/Microsoft.Capacity"
  body = jsonencode({
    properties = {
      principalId      = azuread_service_principal.ternary.id
      principalType    = "ServicePrincipal"
      roleDefinitionId = data.azurerm_role_definition.reservations_reader.id
    }
  })
}
