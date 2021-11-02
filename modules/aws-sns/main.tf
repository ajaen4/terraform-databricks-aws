data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "topic" {
  name              = "${var.tags["project"]}-${var.name}-topic"
  display_name      = "${var.tags["project"]} ${var.name} Topic"
  kms_master_key_id = var.kms_master_key_id
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.topic.arn

  policy = data.aws_iam_policy_document.sns-topic-policy.json
}

data "aws_iam_policy_document" "sns-topic-policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }

    resources = [
      aws_sns_topic.topic.arn,
    ]

    sid = "general"
  }

  statement {
    actions = [
      "SNS:Publish"
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.topic.arn,
    ]

    sid = "cloudtrail"
  }

  statement {
    actions = [
      "SNS:Publish"
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.topic.arn,
    ]

    sid = "cloudwatch"
  }
}

data "template_file" "topics_data" {
  template = file("${path.module}/templates/topics.json.tpl")
  count    = length(var.emails)

  vars = {
    email_address = var.emails[count.index]
    index         = count.index
    topic_arn     = aws_sns_topic.topic.arn
  }
}

data "template_file" "email_sns_stack" {
  template = file("${path.module}/templates/email-sns-stack.json.tpl")

  vars = {
    topics = join(",", data.template_file.topics_data.*.rendered)
  }
}

resource "aws_cloudformation_stack" "sns-topic" {
  name          = format("%s-sns-stack", var.name)
  template_body = data.template_file.email_sns_stack.rendered

  tags = merge(var.tags, { "Name" = format("%s-sns-stack", var.name) })
}
