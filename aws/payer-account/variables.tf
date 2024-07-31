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
}

variable "ternary_bucket_id" {
  type        = string
  description = "S3 bucket name to which your AWS CUR is being written"
}

variable "ternary_role_name" {
  type        = string
  description = "Role name to create in your AWS account. Useful if you will run this twice in the same account."
  default     = "TernaryCMPServiceAgent"
}
