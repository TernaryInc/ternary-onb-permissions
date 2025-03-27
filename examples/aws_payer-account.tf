module "ternary-payer-account" {
  source = "github.com/TernaryInc/ternary-onb-permissions//aws/payer-account?ref=master"

  ternary_bucket_id             = "billing-export"
  ternary_service_account_email = "tenant-feedbaba@ternary-prod-cacc.iam.gserviceaccount.com"
  ternary_service_account_uid   = "5555666667777"
}