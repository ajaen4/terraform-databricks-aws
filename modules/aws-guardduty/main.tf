resource "aws_guardduty_detector" "this" {
  enable                       = var.guardduty_enabled
  finding_publishing_frequency = var.finding_publishing_frequency
}

resource "aws_cloudwatch_event_rule" "this" {
  name        = "guardduty-events"
  description = "GuardDutyEvent"
  is_enabled  = var.guardduty_enabled
  tags        = var.tags

  event_pattern = <<PATTERN
{
  "source": [
    "aws.guardduty"
  ],
  "detail-type": [
    "GuardDuty Finding"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "SendToSNS"
  arn       = var.notification_arn
}

data "aws_s3_bucket" "selected" {
  bucket = var.s3_destination
}

resource "aws_s3_bucket_object" "guardduty_path" {
  bucket = data.aws_s3_bucket.selected.id
  acl    = "private"
  key    = "${var.s3_path}/"
  source = "/dev/null"
}

resource "aws_guardduty_publishing_destination" "publish_s3" {
  detector_id     = aws_guardduty_detector.this.id
  destination_arn = "${data.aws_s3_bucket.selected.arn}/${var.s3_path}"
  kms_key_arn     = var.kms_key_arn

  depends_on = [
    data.aws_s3_bucket.selected, aws_s3_bucket_object.guardduty_path
  ]
}