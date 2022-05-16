# Ternary Onboarding Permissions

Permissions for Ternary to access your cloud for cost insights.

## Download

In order to give permissions to Ternary in gcloud you need to download the appropiate YAML file based on your choice: [Project Custom Role][project custom role yaml] or [Organization Custom Role][org custom role yaml]. Save this file as role.yaml.

You can download the [Project Custom Role][project custom role tf] and [Organization Custom Role][org custom role tf] in Terraform format for your convenience. As Terraform projects vary widely, we do not provide official steps for how to integrate this into your Terraform workspace and leave this step to the reader.

# License

       Copyright 2022 Ternary, Inc.

       Licensed under the Apache License, Version 2.0 (the "License");
       you may not use this file except in compliance with the License.
       You may obtain a copy of the License at

           http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.

[project custom role yaml]: Project-role.yaml
[org custom role yaml]: Org-role.yaml
[project custom role tf]: Project-role.tf
[org custom role tf]: Org-role.tf
