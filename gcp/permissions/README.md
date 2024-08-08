# permissions

Terraform module for granting permissions to Ternary's service account for both your billing export, billing account, and API access.

Example usage:

```hcl
module "ternary-google" {
    source = "git::https://github.com/TernaryInc/ternary-onb-permissions.git//gcp/permissions?ref=master"

    google_cloud_org_domain = "yourcompany.com"
    ternary_service_account_email = "tenant-aaabbb111333@ternary-prod-cacc.iam.gserviceaccount.com"

    billing_export_project = "billing-export-334455"
    billing_export_dataset = "my-export-dataset"
    billing_account_id     = "AABBCC-123456-7890AB"
}
```

## I don't have a billing export yet

Please create the billing export following these [instructions] in the Google Cloud Console. Note the project and dataset you send the billing export to. Please make sure to send both the detailed and standard billing exports to the same location.

[instructions]: https://cloud.google.com/billing/docs/how-to/export-data-bigquery-setup
