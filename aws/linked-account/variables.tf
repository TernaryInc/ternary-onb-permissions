variable "ternary_service_account_email" {
  type        = string
  description = "Service Account email used by your Ternary tenant to access your cloud resources. Available in your Admin page."
}

variable "ternary_service_account_uid" {
  type        = string
  description = "Service Account Unique ID used by your Ternary tenant to access your cloud resources. Available in your Admin page."
  validation {
    condition     = length(regexall("[0-9]+", var.ternary_service_account_uid)) > 0
    error_message = "The ternary_service_account_uid value must be numeric."
  }
}}
