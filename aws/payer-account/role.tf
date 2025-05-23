resource "aws_iam_role" "ternary_cmp_service_agent" {
  name               = var.ternary_role_name
  description        = "Permissions for Ternary to access your cloud for cost insights."
  assume_role_policy = data.aws_iam_policy_document.ternary_cmp_service_agent_assume_role.json
}

resource "aws_iam_role_policy" "ternary_cmp_service_agent" {
  name   = var.ternary_role_name
  role   = aws_iam_role.ternary_cmp_service_agent.name
  policy = data.aws_iam_policy_document.ternary_cmp_service_agent_permissions.json
}

data "aws_iam_policy_document" "ternary_cmp_service_agent_permissions" {
  version = "2012-10-17"
  statement {
    sid    = "AccountAccess"
    effect = "Allow"
    actions = [
      "ce:GetReservationPurchaseRecommendation",
      "ce:GetRightsizingRecommendation",
      "ce:GetSavingsPlansPurchaseRecommendation",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:ListMetricStreams",
      "cloudwatch:ListTagsForResource",
      "compute-optimizer:GetAutoScalingGroupRecommendations",
      "compute-optimizer:GetEBSVolumeRecommendations",
      "compute-optimizer:GetEC2InstanceRecommendations",
      "compute-optimizer:GetIdleRecommendations",
      "compute-optimizer:GetLambdaFunctionRecommendations",
      "dynamodb:DescribeTable",
      "dynamodb:ListTables",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "ec2:DescribeReservedInstances",
      "ec2:DescribeReservedInstancesModifications",
      "ec2:DescribeSnapshots",
      "ec2:DescribeVolumes",
      "ec2:GetReservedInstancesExchangeQuote",
      "ecs:DescribeClusters",
      "ecs:DescribeContainerInstances",
      "ecs:ListClusters",
      "ecs:ListContainerInstances",
      "elasticache:DescribeCacheClusters",
      "elasticache:DescribeReservedCacheNodes",
      "elasticache:ListTagsForResource",
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:ListClusters",
      "elasticmapreduce:ListInstances",
      "es:DescribeReservedInstances",
      "lambda:ListFunctions",
      "lambda:ListProvisionedConcurrencyConfigs",
      "memorydb:DescribeReservedNodes",
      "organizations:ListAccounts",
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances",
      "rds:DescribeOrderableDBInstanceOptions",
      "rds:DescribeReservedDBInstances",
      "rds:DescribeReservedDBInstancesOfferings",
      "rds:ListTagsForResource",
      "redshift:DescribeClusters",
      "redshift:DescribeReservedNodes",
      "redshift:DescribeTags",
      "s3:GetLifecycleConfiguration",
      "s3:ListAllMyBuckets",
      "savingsplans:DescribeSavingsPlans"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "CurAccess"
    effect = "Allow"
    actions = [
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:ListBucketVersions",
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      "arn:aws:s3:::${var.ternary_bucket_id}/*",
      "arn:aws:s3:::${var.ternary_bucket_id}"
    ]
  }
}

data "aws_iam_policy_document" "ternary_cmp_service_agent_assume_role" {
  version = "2012-10-17"
  statement {
    sid     = "TernaryCMPServiceAgentAssumeRole"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      type        = "Federated"
      identifiers = ["accounts.google.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "accounts.google.com:aud"
      values   = [var.ternary_service_account_uid]
    }
    condition {
      test     = "StringEquals"
      variable = "accounts.google.com:oaud"
      values   = [var.ternary_service_account_email]
    }
    condition {
      test     = "StringEquals"
      variable = "accounts.google.com:sub"
      values   = [var.ternary_service_account_uid]
    }
    condition {
      test     = "Null"
      variable = "accounts.google.com:aud"
      values   = [false]
    }
    condition {
      test     = "Null"
      variable = "accounts.google.com:oaud"
      values   = [false]
    }
  }
}
