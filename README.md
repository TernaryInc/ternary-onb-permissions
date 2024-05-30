# Ternary Onboarding Permissions

In this repo, Ternary enumerates the list of permissions that are required to onboard to the platform for supported cloud providers. For your convenience, they are provided in multiple formats: Terraform, YAML configuration files, Cloud Formation where applicable.

## GCP

In order to give permissions to the Ternary service account you were provided in initial onboarding steps, you'll need to download the appropriate YAML based on your choice to onboard a single project or an entire organization: [Project Custom Role][project custom role yaml] or [Organization Custom Role][org custom role yaml] respectively.

You can download the [Project Custom Role][project custom role tf] and [Organization Custom Role][org custom role tf] in Terraform format for your convenience. As Terraform projects vary widely, we do not provide official steps for how to integrate this into your Terraform workspace and leave this step to the reader.

## AWS

Permissions necessary to onboard AWS by creating the required role are outlined in [Terraform](./aws/aws-role-create-tform.tf) and [Cloud Formation](./aws/aws-role-create-cfn.json).

## Azure

For your validating convenience, Ternary's public Azure pem file is located in [Azure pem](./azure/ca.pem).

Use the terraform module in `azure/terraform` to automatically deploy Azure permissions to your Azure environment. You only need the client certificate PEM downloaded from your Admin page.

# License

       Copyright 2023 Ternary, Inc.

       Licensed under the Apache License, Version 2.0 (the "License");
       you may not use this file except in compliance with the License.
       You may obtain a copy of the License at

           http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.

[project custom role yaml]: ./gcp/Project-role.yaml
[org custom role yaml]: ./gcp/Org-role.yaml
[project custom role tf]: ./gcp/Project-role.tf
[org custom role tf]: ./gcp/Org-role.tf
