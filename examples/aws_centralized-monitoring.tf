module "ternary-centralized-monitoring" {
  source = "github.com/TernaryInc/ternary-onb-permissions//aws/centralized-monitoring?ref=master"

  ternary_service_account_email = "tenant-feedbaba@ternary-prod-cacc.iam.gserviceaccount.com"
  ternary_service_account_uid   = "5555666667777"
}