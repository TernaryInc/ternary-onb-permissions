resource "azuread_application_registration" "ternary" {
  display_name     = "Ternary"
  description      = "Cloud cost management platform"
  sign_in_audience = "AzureADMyOrg"
  homepage_url     = "https://ternary.app"
}

resource "azuread_application_certificate" "ternary" {
  application_id = azuread_application_registration.ternary.id
  type           = "AsymmetricX509Cert"
  value          = file(var.client_certificate_path)
  encoding       = "pem"
}

resource "azuread_service_principal" "ternary" {
  client_id                    = azuread_application_registration.ternary.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}
