# Ternary Onboarding Permissions

In this repo, Ternary enumerates the list of permissions that are required to onboard to the platform for supported cloud providers. For your convenience, they are provided in multiple formats: Terraform, YAML configuration files, Cloud Formation where applicable.

## GCP

Use the terraform module in `gcp/permissions` to automatically deploy Ternary
permissions into your Google Cloud environment. You'll need the service account
email and the billing export information. If you'd like us to help you create a
billing export, there's an accompanying module, `gcp/billing-export` that you
can use. For a recipe that combines both modules, check out the [GCP Permissions README.md](./gcp/permissions/README.md).

## AWS

Use the terraform module in `aws/payer-account` to automatically deploy Ternary
permissions into your AWS environment. You'll need the service account email
and service account UID.

Check out the [AWS README.md](./aws/README.md) for more information on other
modules we provide.

## Azure

For your validating convenience, Ternary's public Azure pem file is located in
[Azure pem](./azure/ca.pem).

Use the terraform module in `azure/terraform` to automatically deploy Azure
permissions to your Azure environment. You only need the client certificate PEM
downloaded from your Admin page.

## License

       Copyright 2025 Ternary, Inc.

       Licensed under the Apache License, Version 2.0 (the "License");
       you may not use this file except in compliance with the License.
       You may obtain a copy of the License at

           http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.
