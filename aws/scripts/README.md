# AWS Multi Account Onboarding Instructions
### Why use this script?
The primary reason to use this script is to enable centralized, multi-account monitoring in AWS. You may choose to do this via the AWS console, but the process involves multiple steps that can be prone to human error. Additionally, this process must be repeated in each AWS region you wish to collect metrics in. This script will automate the process and deploy the necessary resources in each region you specify (or all AWS default regions) for a quick and seamless onboarding to AWS Centralized CloudWatch Monitoring.

### Prerequisites:
- [`Python3`](https://www.python.org/downloads/) (We're using 3.11)
- `Pip3` (Comes standard with Python > 3.4)
- Optional, but highly recommended `VirtualEnv`
  - `pip3 install virtualenv`
- AWS CLI Credentials for your management account

### Setup your environment
- If you have `virtualenv` installed:
  - `source env_setup.sh`
- If you don't have `virtualenv`:
  - `pip3 install -r requirements.txt`

### Run the script
- `python3 create_links_sinks.py --sink-name SINK-NAME --regions "region1,region2,region3" --profile AWS-CLI-PROFILE --organization ORGANIZATION --organization-unit ORGANIZATION-UNIT --excluded-accounts "accountID1,accountID2,accountID3"`
  - `sink-name`: Human-friendly name for your sink and StackSet
  - `regions`: _Optional_ Double quoted, comma separated list of regions to create a sink and StackSet in
    - **Do not add spaces between regions**
    - If not specified, uses Regions enabled by default in an AWS Account ("us-east-2", "us-east-1", "us-west-1", "us-west-2",
		"ap-south-1", "ap-northeast-3", "ap-northeast-2", "ap-southeast-1", "ap-southeast-2",
		"ap-northeast-1", "ca-central-1", "eu-central-1", "eu-west-1", "eu-west-2", "eu-west-3",
		"eu-north-1", "sa-east-1")
  - `profile`: AWS CLI Credentials profile. If not specified, uses the default profile
  - `organization`: Unique identifier for your organization
    - Navigate to [Organizations](https://us-east-1.console.aws.amazon.com/organizations/v2/home/accounts), click on Root, and get the string starting with o- from your organization ARN
    - arn:aws:organizations::01234567890:root/o-oooo1oo1oo/r-root -> o-oooo1oo1oo
  - `organization-unit`: Organization unit that you want to centralize monitoring for
    - We recommend root (arn:aws:organizations::01234567890:root/o-oooo1oo1oo/r-root -> r-root)
    - Can also be a sub-ou (arn:aws:organizations::01234567890:root/o-oooo1oo1oo/ou-root-ooooo1oo -> ou-root-ooooo1oo)
  - `excluded-accounts`: _Optional_ Double quoted, comma separated list of accounts to exclude from centralized monitoring
    - **Suspended accounts MUST be excluded**
    - **Do not add spaces between excluded accounts**

### Verify your resources are configured and your stack nstances are created as intended

### Tear down your environment
- Only if using `virtualenv`: 
  - `source env_teardown.sh`
