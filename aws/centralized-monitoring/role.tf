resource "aws_iam_role" "ternary_cmp_monitoring_agent" {
  name               = "TernaryCMPMonitoringAgent"
  description        = "Permissions for Ternary to access your cloud for cost insights."
  assume_role_policy = data.aws_iam_policy_document.ternary_cmp_monitoring_agent_assume_role.json
}

resource "aws_iam_role_policy" "ternary_cmp_monitoring_agent" {
  name   = "TernaryCMPMonitoringAgent"
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
