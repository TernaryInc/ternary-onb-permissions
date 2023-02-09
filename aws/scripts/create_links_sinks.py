#!/usr/bin/env python3
import argparse
import boto3
from jinja2 import Environment, FileSystemLoader, select_autoescape

# Set up parser to accept CLI flags
parser = argparse.ArgumentParser(add_help=True)
parser.add_argument('--organization', help="AWS Organization", type=str)
parser.add_argument('--organization-unit', help="AWS Organization Unit", type=str)
parser.add_argument('--sink-name', help="Human-friendly AWS Metric Sink Name, defaults to \"Centralized-Monitoring\"", type=str)
parser.add_argument('--profile', help="AWS CLI Config Profile Name for the Management Account, uses your default AWS profile if not specified", type=str)
parser.add_argument('--regions', help="Double quoted, comma separated list of regions to create a sink and StackSet in. If not specified, ", type=str)
parser.add_argument('--excluded-accounts', help="[Optional] double quoted, comma separated list of accounts to exclude (ex. --exclude \"12345678910, 09876543210\"). Must exclude suspended accounts", type=str)

# AWS Default regions
aws_default_regions = ["us-east-2", "us-east-1", "us-west-1", "us-west-2",
		"ap-south-1", "ap-northeast-3", "ap-northeast-2", "ap-southeast-1", "ap-southeast-2",
		"ap-northeast-1", "ca-central-1", "eu-central-1", "eu-west-1", "eu-west-2", "eu-west-3",
		"eu-north-1", "sa-east-1"]

policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":[\"oam:CreateLink\",\"oam:UpdateLink\"],\"Resource\":\"*\",\"Condition\":{\"ForAllValues:StringEquals\":{\"oam:ResourceTypes\":\"AWS::CloudWatch::Metric\"},\"ForAnyValue:StringEquals\":{\"aws:PrincipalOrgID\":\"%s\"}}}]}"

# Returns an instance of a client for a given service, in a given region, with a given profile
def get_client(profile, service, region):
    return boto3.Session(profile_name=profile, region_name=region).client(service)

# Creates a sink in the provided region, and attaches the above policy to it
def create_sink(region, profile, sink_name, organization):
    # Get OAM client
    client = get_client(profile, 'oam', region)

    # Create an OAM sink in the specified region
    try:
        sink = client.create_sink(
            Name=sink_name
        )
    except Exception:
        raise Exception('creating sink')
    
    # Put organization in the policy string
    formatted_policy = policy % organization

    # Attach policy to sink
    try:
        client.put_sink_policy(
            SinkIdentifier=sink['Arn'],
            Policy=formatted_policy
        )
    except Exception:
        raise Exception('adding policy to sink')
    
    return sink['Arn']

# Renders link-cfn-template.yaml as a string with user provided arguments
def render_template(monitoring_account_id, sink_arn):
    env = Environment(
        loader=FileSystemLoader('./'),
        autoescape=select_autoescape())
    template = env.get_template('link-cfn-template.yaml')
    return template.render(MonitoringAccountID=monitoring_account_id, SinkARN=sink_arn)

# Creates a stackset and stack instances that create links to the created sink
def create_stackset(region, profile, sink_arn, organization_unit, stack_set_name, excluded_accounts):
    # Get CFN Client
    client = get_client(profile, 'cloudformation', region)

    # Get account ID from caller identity
    try:
        account_id = get_client(profile, 'sts', region).get_caller_identity()['Account']
    except Exception:
        raise Exception('get account id')

    # Execute template
    try:
        rendered_template = render_template(monitoring_account_id=account_id, sink_arn=sink_arn)
    except Exception:
        raise('rendering template')
    
    # Create stackset
    try:
        stack_set = client.create_stack_set(
            StackSetName=stack_set_name,
            Description="Source Account Links To Enable Cross-Account Monitoring",
            TemplateBody=rendered_template,
            PermissionModel='SERVICE_MANAGED',
            AutoDeployment={
                'Enabled': True,
                'RetainStacksOnAccountRemoval': False
            }
        )
    except Exception:
        raise('creating stack set')

    # Set DeploymentTargets
    deployment_targets={
        'OrganizationalUnitIds': [
            organization_unit,
        ],
        'AccountFilterType': 'NONE'
    }
    if excluded_accounts is not None:
        deployment_targets['Accounts'] = excluded_accounts
        deployment_targets['AccountFilterType'] = 'DIFFERENCE'

    # Create stack instances
    client.create_stack_instances(
        StackSetName=stack_set['StackSetId'],
        DeploymentTargets=deployment_targets,
        Regions=[region],
        OperationPreferences={
            'RegionConcurrencyType': 'SEQUENTIAL',
            'MaxConcurrentCount': 1,
        }
    )
    return

def monitoring_onboarding():
    # Fetch/validate CLI args
    args = parser.parse_args()
    arg_dict = vars(args)
    if arg_dict['organization'] is not None:
        organization = arg_dict['organization']
    else:
        raise Exception('--organization-id is required')

    if arg_dict['organization_unit'] is not None:
        organization_unit = arg_dict['organization_unit']
    else:
        raise Exception('--organization-unit is required')

    if arg_dict['regions'] is not None:
        regions = arg_dict['regions'].split(',')
    else:
        regions = aws_default_regions
    
    sink_name = 'Centralized-Monitoring'
    if arg_dict['sink_name'] is not None:
        sink_name = arg_dict['sink_name']

    profile = None
    if arg_dict['profile'] is not None:
        profile = arg_dict['profile']

    excluded_accounts = None
    if arg_dict['excluded_accounts'] is not None:
        excluded_accounts = arg_dict['excluded_accounts'].split(',')
    print("========== STARTING ==========")
    # iterate over regions, creating sinks and stacksets
    for region in regions:
        # strip any accidental spaces
        region = region.strip(" ")
        print(f'creating sink in {region}')
        try:
            sink_arn = create_sink(region=region, profile=profile, sink_name=sink_name, organization=organization)
        except Exception as err:
            raise Exception(f'creating sink in {region}')
        print(f'successfully created sink in {region}')
        print(f'creating stackset and stacks in {region}')
        try:
            create_stackset(region=region, profile=profile, sink_arn=sink_arn, organization_unit=organization_unit, stack_set_name=sink_name, excluded_accounts=excluded_accounts)
        except Exception as err:
            raise Exception(f'creating stackset in {region}') from err
        print(f'successfully created stackset and stacks in {region}')
    print("========== COMPLETED ==========")
    return

if __name__ == "__main__":  
    monitoring_onboarding()