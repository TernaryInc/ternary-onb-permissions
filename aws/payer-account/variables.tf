variable "ternary_service_account_email" {
  type        = string
  description = "Service Account email used by your Ternary tenant to access your cloud resources. Available in your Admin page."
}

variable "ternary_service_account_uid" {
  type        = string
  description = "Service Account Unique ID used by your Ternary tenant to access your cloud resources. Available in your Admin page."
}

variable "ternary_bucket_id" {
  type        = string
  description = "S3 bucket name to which your AWS CUR is being written"
}
