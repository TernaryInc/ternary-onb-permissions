# linked-account

This is simultaneously a Terraform module as well as a repository housing an
equivalent CloudFormation template, `ternary-linked-account-cfn.json`.
Uploading a CloudFormation template to the AWS console is an exercise left to
the reader, but see below for an example invocation of this module in
Terraform.

Either approach will create a `TernaryCMPLinkedAccountAgent` role in a linked
AWS account from which you would like to gather metrics.

These steps must be repeated for all linked accounts you wish to connect to
Ternary, then you must all role ARNsto your Success Team.

To obtain the values for `ternary_service_account_email` and
`ternary_service_account_uid`, look at your Ternary Admin page.

## Example terraform usage

```hcl
module "ternary-linked-account" {
    source = "git::https://github.com/TernaryInc/ternary-onb-permissions.git//aws/linked-account?ref=master"

    ternary_service_account_email = "tenant-feedbaba@ternary-prod-cacc.iam.gserviceaccount.com"
    ternary_service_account_uid   = "5555666667777"
}
```

[aws-centralized-monitoring]: https://github.com/TernaryInc/aws-centralized-monitoring
