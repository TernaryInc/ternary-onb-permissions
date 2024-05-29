resource "time_static" "creation" {}

resource "azurerm_billing_account_cost_management_export" "actuals" {
  name                         = "ternary-actuals"
  billing_account_id           = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_id}"
  recurrence_type              = "Daily"
  recurrence_period_start_date = time_static.creation.rfc3339
  recurrence_period_end_date   = "2099-01-01T00:00:00Z"

  export_data_storage_location {
    container_id     = azurerm_storage_container.ternary.resource_manager_id
    root_folder_path = "actuals"
  }

  export_data_options {
    type       = "ActualCost"
    time_frame = "MonthToDate"
  }
}

resource "azurerm_billing_account_cost_management_export" "amortized" {
  name                         = "ternary-amortized"
  billing_account_id           = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_id}"
  recurrence_type              = "Daily"
  recurrence_period_start_date = time_static.creation.rfc3339
  recurrence_period_end_date   = "2099-01-01T00:00:00Z"

  export_data_storage_location {
    container_id     = azurerm_storage_container.ternary.resource_manager_id
    root_folder_path = "amortized"
  }

  export_data_options {
    type       = "AmortizedCost"
    time_frame = "MonthToDate"
  }
}

# azurerm is not capable of this granting the App access to the billing account
# https://github.com/Azure/terraform-provider-azapi/issues/400
# https://github.com/hashicorp/terraform-provider-azurerm/issues/15211

resource "azapi_resource_action" "add_billing_reader" {
  type                   = "Microsoft.Billing/billingAccounts@2019-10-01-preview"
  resource_id            = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_id}"
  action                 = "createBillingRoleAssignment"
  method                 = "POST"
  when                   = "apply"
  response_export_values = ["*"]
  body = jsonencode({
    properties = {
      principalId      = azuread_service_principal.ternary.id
      roleDefinitionId = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_id}/billingRoleDefinitions/50000000-aaaa-bbbb-cccc-100000000002"
    }
  })
}

resource "azapi_resource_action" "remove_billing_reader" {
  type        = "Microsoft.Billing/billingAccounts/billingRoleAssignments@2019-10-01-preview"
  resource_id = jsondecode(azapi_resource_action.add_billing_reader.output).id
  method      = "DELETE"
  when        = "destroy"
}
