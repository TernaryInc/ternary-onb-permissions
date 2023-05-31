locals {
  ternary_bucket_id   = "<INSERT_S3_BUCKET_NAME>"
  ternary_service_account = "<INSERT_SERVICE_ACCOUNT>"
  ternary_service_account_uid = "<INSERT_SERVICE_ACCOUNT_UID>"
}
resource "aws_iam_role" "ternary_cmp_service_agent" {
  name               = "ternary-cmp-service-agent"
  description        = "Permissions for Ternary to access your cloud for cost insights."
  assume_role_policy = data.aws_iam_policy_document.ternary_cmp_service_agent_assume_role.json
}
resource "aws_iam_role_policy" "ternary_cmp_service_agent" {
  name   = "ternary-cmp-service-agent"
  role   = aws_iam_role.ternary_cmp_service_agent.name
  policy = data.aws_iam_policy_document.ternary_cmp_service_agent_permissions.json
}
data "aws_iam_policy_document" "ternary_cmp_service_agent_permissions" {
  version = "2012-10-17"
  statement {
    sid    = "AccountAccess"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetLifecycleConfiguration",
      "cloudwatch:GetMetricData",
      "cloudwatch:ListMetricStreams",
      "cloudwatch:ListTagsForResource",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "compute-optimizer:GetEC2InstanceRecommendations",
      "compute-optimizer:GetAutoScalingGroupRecommendations",
      "compute-optimizer:GetEBSVolumeRecommendations",
      "compute-optimizer:GetLambdaFunctionRecommendations",
      "rds:DescribeOrderableDBInstanceOptions",
      "rds:DescribeReservedDBInstancesOfferings",
      "ce:GetReservationPurchaseRecommendation",
      "ce:GetSavingsPlansPurchaseRecommendation",
      "ce:GetRightsizingRecommendation",
      "EC2:DescribeVolumes",
      "EC2:DescribeInstances",
      "lambda:ListFunctions",
      "lambda:ListProvisionedConcurrencyConfigs"
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
      "arn:aws:s3:::${local.ternary_bucket_id}/*",
      "arn:aws:s3:::${local.ternary_bucket_id}"
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
      values   = local.ternary_service_account_uid
    }
    condition {
      test     = "StringEquals"
      variable = "accounts.google.com:oaud"
      values   = local.ternary_service_account
    }
    condition {
      test     = "StringEquals"
      variable = "accounts.google.com:sub"
      values   = local.ternary_service_account_uid
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
