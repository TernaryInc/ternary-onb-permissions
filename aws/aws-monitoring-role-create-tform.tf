locals {
  ternary_external_id = "<INSERT_EXTERNAL_ID>"
}
resource "aws_iam_role" "ternary_cmp_monitoring_agent" {
  name               = "ternary-cmp-monitoring-agent"
  description        = "Permissions for Ternary to access your cloud for cost insights."
  assume_role_policy = data.aws_iam_policy_document.ternary_cmp_monitoring_agent_assume_role.json
}
resource "aws_iam_role_policy" "ternary_cmp_monitoring_agent" {
  name   = "ternary-cmp-monitoring-agent"
  role   = aws_iam_role.ternary_cmp_monitoring_agent.name
  policy = data.aws_iam_policy_document.ternary_cmp_monitoring_agent_permissions.json
}
data "aws_iam_policy_document" "ternary_cmp_monitoring_agent_permissions" {
  version = "2012-10-17"
  statement {
    sid    = "AccountAccess"
    effect = "Allow"
    actions = [
      "cloudwatch:GetMetricData",
      "cloudwatch:ListMetricStreams",
      "cloudwatch:ListTagsForResource",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics"
    ]
    resources = ["*"]
  }
}
data "aws_iam_policy_document" "ternary_cmp_monitoring_agent_assume_role" {
  version = "2012-10-17"
  statement {
    sid     = "TernaryCMPmonitoringAgentAssumeRole"
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
