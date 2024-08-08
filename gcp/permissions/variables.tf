variable "ternary_service_account_email" {
  type        = string
  description = "Service Account email used by your Ternary tenant to access your cloud resources. Available in your Admin page."
}

variable "google_cloud_org_domain" {
  type        = string
  description = "Google Cloud organization domain name (e.g., yourcompany.com)"
}

variable "billing_export_project_id" {
  type        = string
  description = "Google Cloud project ID that contains your billing export"
}

variable "billing_export_dataset" {
  type        = string
  description = "Google Cloud dataset that contains your billing export, within the billing export project"
}

variable "billing_account_id" {
  type        = string
  description = "Google Cloud Billing ID"

  validation {
    condition     = length(regexall("[0-9A-F]{6}-[0-9A-F]{6}-[0-9A-F]{6}", var.billing_account_id)) > 0
    error_message = "The billing_account_id should look like: ABCDEF-123456-FEDCBA"
  }
}
