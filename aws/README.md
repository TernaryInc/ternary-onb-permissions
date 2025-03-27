# Onboard AWS to Ternary

This directory contains the necessary scripts to onboard your AWS accounts into Ternary. These scripts enable Ternary to:

* Access S3 to read your Cost and Usage Export
* Access CloudWatch to download real-time usage metrics
* Access other service APIs to gather rate and usage optimization information

## Available Modules

The following modules are available in both CloudFormation and Terraform formats. For a fully featured AWS integration with multiple member accounts, you'll typically use all three modules:

### 1. Payer Account Module (Required)

Located in the `payer-account` directory, this creates the `TernaryCMPServiceAgent` role. This role:

* Must be created in the AWS account where your Cost and Usage Report (CUR) is generated
* Enables Ternary to:
  * Ingest your Cost and Usage Report
  * List centrally purchased commitments
  * Gather recommendations

### 2. Centralized Monitoring Module

Located in the `centralized-monitoring` directory, this creates the `TernaryCMPMonitoringAgent` role. This role:

* Should be configured in either:
  * An AWS management account
  * An AWS account dedicated to centralized CloudWatch Monitoring
* Enables Ternary to gather AWS metrics across your entire organization from a single account
* Works in conjunction with the [aws-centralized-monitoring] repository to access aggregated metrics

### 3. Linked Account Module

Located in the `linked-account` directory, this creates the `TernaryCMPLinkedAccountAgent` role. This role:

* Should be created in each Linked Account containing resources you want Ternary to monitor
* Enables monitoring of resources like Reserved Instances and Savings Plans

[aws-centralized-monitoring]: https://github.com/TernaryInc/aws-centralized-monitoring
