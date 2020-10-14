#Module      : SNS
#Description : Output of resources created on AWS.
output "sns_topic_arn" {
  value       = join("", aws_sns_topic.default.*.arn)
  description = "The ARN of the SNS topic."
}

output "sns_topic_subscription_arn" {
  value = {
    for x in aws_sns_topic_subscription.default:
    x.topic_arn => x.arn...
  }
  description = "The ARN of the subscription."
}

output "sns_topic_subscription_protocol" {
  value = {
    for x in aws_sns_topic_subscription.default:
    x.topic_arn => x.protocol...
  }
  description = "The protocol being used in subscription."
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of tags to assign to the resource."
}