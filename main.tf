#Module      : LABELS
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.
module "labels" {
  source = "git::https://github.com/aashishgoyal246/terraform-labels.git?ref=tags/0.13.0"

  name        = var.name
  application = var.application
  environment = var.environment
  enabled     = var.enabled
  label_order = var.label_order
  tags        = var.tags
}

#Module      : SNS TOPIC
#Description : Terraform module to create sns topic resource on AWS.
resource "aws_sns_topic" "default" {
  count             = var.enabled ? 1 : 0
  name              = format("%s-topic", module.labels.id)
  kms_master_key_id = var.kms_master_key_id
  tags              = module.labels.tags
}

#Module      : SNS TOPIC POLICY
#Description : Terraform module to create sns topic policy resource on AWS.
resource "aws_sns_topic_policy" "default" {
  count = var.enabled && var.policy_enabled ? 1 : 0
  arn   = join("", aws_sns_topic.default.*.arn)
  
  policy = join("", data.aws_iam_policy_document.iam_policy.*.json)

  depends_on = [
    aws_sns_topic.default
  ] 
}

data "aws_iam_policy_document" "iam_policy" {
  count = var.enabled && var.policy_enabled ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = ["SNS:Publish"]
    resources = [join("", aws_sns_topic.default.*.arn)]
    
    principals {
      type        = "Service"
      identifiers = var.allowed_services_for_sns_publish
    }
  }
}

#Module      : SNS TOPIC POLICY SUBSCRIPTION
#Description : Terraform module to create sns topic policy subscription resource on AWS.
resource "aws_sns_topic_subscription" "default" {
  for_each = var.topic_subscribers

  topic_arn = join("", aws_sns_topic.default.*.arn)
  protocol  = each.value.protocol
  endpoint  = each.value.endpoint

  depends_on = [
    aws_sns_topic.default,
    aws_sns_topic_policy.default
  ]
}