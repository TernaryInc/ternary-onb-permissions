module "ternary-google" {
  source = "github.com/TernaryInc/ternary-onb-permissions//gcp/permissions?ref=master"

  google_cloud_org_domain       = "yourcompany.com"
  ternary_service_account_email = "tenant-aaabbb111333@ternary-prod-cacc.iam.gserviceaccount.com"

  billing_export_project = "billing-export-334455"
  billing_export_dataset = "my-export-dataset"
  billing_account_id     = "AABBCC-123456-7890AB"
}