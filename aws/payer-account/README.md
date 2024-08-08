# payer-account

This is simultaneously a Terraform module as well as a repository housing an
equivalent CloudFormation template, `ternary-payer-account-cfn.json`. Uploading
a CloudFormation template to the AWS console is an exercise left to the reader,
but see below for an example invocation of this module in Terraform.

Either approach will create a `TernaryCMPServiceAgent` role whose ARN you
should copy and paste into the `Role ARN` field inside Ternary.

To obtain the values for `ternary_service_account_email` and
`ternary_service_account_uid`, look at your Ternary Admin page.

To obtain the value for `ternary_bucket_id`, follow the instructions to
set up an AWS CUR export to an S3 bucket. This bucket ID is what you should
use for the value.

## Example terraform usage

```hcl
module "ternary-payer-account" {
    source = "git::https://github.com/TernaryInc/ternary-onb-permissions.git//aws/payer-account?ref=master"

    ternary_bucket_id             = "my-awesome-cur-bucket-001"
    ternary_service_account_email = "tenant-feedbaba@ternary-prod-cacc.iam.gserviceaccount.com"
    ternary_service_account_uid   = "5555666667777"
}
```
