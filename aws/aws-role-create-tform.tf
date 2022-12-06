locals {
  ternary_external_id = "<INSERT_EXTERNAL_ID>"
  ternary_bucket_id   = "<INSERT_S3_BUCKET_NAME>"
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
      "cloudwatch:GetMetricData",
      "cloudwatch:ListMetricStreams",
      "cloudwatch:ListTagsForResource",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "compute-optimizer:GetEC2InstanceRecommendations",
      "compute-optimizer:GetAutoScalingGroupRecommendations",
      "compute-optimizer:GetEBSVolumeRecommendations",
      "rds:DescribeReservedDBInstancesOfferings",
      "ce:GetReservationPurchaseRecommendation",
      "ce:GetSavingsPlansPurchaseRecommendation",
      "EC2:DescribeVolumes",
      "EC2:DescribeInstances"
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
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["638468855455"]
    }
    condition {
      test     = "StringEquals"
      values   = [local.ternary_external_id]
      variable = "sts:ExternalId"
    }
  }
}
