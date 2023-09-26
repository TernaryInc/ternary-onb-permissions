# AWS Permissions

## What are the 3 Directories For?

The 3 directories each hold a CloudFormation and Terraform file for creating roles, and each role allows Ternary to access different parts of your AWS footprint

### payer-account
*THIS ROLE IS REQUIRED TO ONBOARD AN AWS CLOUD TO TERNARY*
The payer-account directory houses the code necessary to create the `TernaryCMPServiceAgent` role. This role MUST be created in the AWS account your Cost and Usage Report (CUR) is generated in. This role allows Ternary to ingest your Cost and Usage Report, as well as listing any commitments you have centrally purchased and gather recommendations.


### centralized-monitoring
The centralized-monitoring directory houses the code necessary to create the `TernaryCMPMonitoringAgent` role. This role is meant to be configured in either an AWS management account or an AWS account dedicated to centralized CloudWatch Monitoring. AWS Centralized Monitoring allows Ternary to gather AWS Metrics of interest from across your whole AWS organization while only needing to connect to one account, instead of each account individually


### linked-account
The linked-account directory houses the code necessary to create the `TernaryCMPLinkedAccountAgent` role. This role is meant for any Linked Account with resources that you would like Ternary to be made aware of (Reserved Instances, Savings Plans, etc.)
