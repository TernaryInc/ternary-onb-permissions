# Onboard AWS to Ternary

The scripts within this directory help you to onboard your AWS accounts into
Ternary. Generally speaking, Ternary will:

* Access S3 in order to read your Cost and Usage Export.
* Access CloudWatch in order to download usage metrics in real-time.
* Access other service APIs in order to get information about rate and usage optimization.

There are 3 different modules in this directory; all of them are provided in
both CloudFormation and Terraform format. Each role allows Ternary to access
different parts of your AWS environment. For an AWS Organization with multiple
member accounts, a fully featured AWS integration will typically use all three
modules.

## payer-account

*THIS ROLE IS REQUIRED TO ONBOARD AN AWS CLOUD TO TERNARY.*

The payer-account directory houses the code necessary to create the
`TernaryCMPServiceAgent` role. This role MUST be created in the AWS account
your Cost and Usage Report (CUR) is generated in. This role allows Ternary to
ingest your Cost and Usage Report, as well as listing any commitments you have
centrally purchased and gather recommendations.

## centralized-monitoring

The centralized-monitoring directory houses the code necessary to create the
`TernaryCMPMonitoringAgent` role. This role is meant to be configured in either
an AWS management account or an AWS account dedicated to centralized CloudWatch
Monitoring. AWS Centralized Monitoring allows Ternary to gather AWS Metrics of
interest from across your whole AWS organization while only needing to connect
to one account, instead of each account individually.

This role is designed to be used in conjunction with the
[aws-centralized-monitoring] repository. By running the scripts in that
repository to transfer metrics from all your linked accounts to the centralized
monitoring account, Ternary will use this role to then access the aggregated
metrics.

## linked-account

The linked-account directory houses the code necessary to create the
`TernaryCMPLinkedAccountAgent` role. This role is meant for any Linked Account
with resources that you would like Ternary to be made aware of (Reserved
Instances, Savings Plans, etc.), and should be created in each Linked Account.

[aws-centralized-monitoring]: https://github.com/TernaryInc/aws-centralized-monitoring
