# Ternary Onboarding Permissions

Permissions for Ternary to access your cloud for cost insights.

## Download

In order to give permissions to Ternary in gcloud you need to download the appropiate YAML file based on your choice: [Project Custom Role][project custom role yaml] or [Organization Custom Role][org custom role yaml]. Save this file as role.yaml.

You can download the [Project Custom Role][project custom role tf] and [Organization Custom Role][org custom role tf] in Terraform format for your convenience. As Terraform projects vary widely, we do not provide official steps for how to integrate this into your Terraform workspace and leave this step to the reader.

# License

    Copyright 2022 Ternary, Inc.

    TBD

[project custom role yaml]: https://github.com/TernaryInc/ternary-onb-permissions/blob/master/Project-role.yaml
[org custom role yaml]: https://github.com/TernaryInc/ternary-onb-permissions/blob/master/Org-role.yaml
[project custom role tf]: https://github.com/TernaryInc/ternary-onb-permissions/blob/master/Project-role.tf
[org custom role tf]: https://github.com/TernaryInc/ternary-onb-permissions/blob/master/Org-role.tf