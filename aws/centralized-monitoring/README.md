# centralized-monitoring

This is simultaneously a Terraform module as well as a repository housing an
equivalent CloudFormation template, `ternary-monitoring-cfn.json`. Uploading a
CloudFormation template to the AWS console is an exercise left to the reader,
but see below for an example invocation of this module in Terraform.

Either approach will create a `TernaryCMPMonitoringAgent` role whose ARN you
should copy and paste into the `Metrics Collection Role ARN` field inside
Ternary's AWS cloud configuration.

To obtain the values for `ternary_service_account_email` and
`ternary_service_account_uid`, look at your Ternary Admin page.

If you are using the [aws-centralized-monitoring] script and are directing
metrics to flow into the account where you applied the [payer-account] role,
then you do not need to apply this. Simply use the same role ARN generated from
the `payer-account` module.

## Example terraform usage

```hcl
module "ternary-centralized-monitoring" {
    source = "https://github.com/TernaryInc/ternary-onb-permissions.git//aws/centralized-monitoring?ref=master"

    ternary_service_account_email = "tenant-feedbaba@ternary-prod-cacc.iam.gserviceaccount.com"
    ternary_service_account_uid   = "5555666667777"
}
```

[aws-centralized-monitoring]: https://github.com/TernaryInc/aws-centralized-monitoring
[payer-account]: https://github.com/TernaryInc/ternary-onb-permissions/tree/master/aws/payer-account
