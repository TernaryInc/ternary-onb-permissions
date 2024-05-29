variable "location" {
  type        = string
  description = "Location to create Azure resources in."
  default     = "East US"
}

variable "enhanced_access_scopes" {
  type        = list(string)
  description = "Scopes (management group or subscription) to apply enhanced access for Ternary to pull metrics for cost awareness. Example: /subscriptions/GUID, /providers/Microsoft.Management/managementGroups/GUID"
}

variable "billing_account_id" {
  type        = string
  description = "Billing Account ID to create exports and grant Ternary permission. Usually in form: GUID1:GUID2_DATE"
}

variable "client_certificate_path" {
  type        = string
  description = "Path to downloaded Ternary_Azure.pem file."
}

variable "create_billing_export" {
  type        = bool
  description = "Leave as true to create billing exports compliant with Ternary onboarding requirements."
  default     = true
}
