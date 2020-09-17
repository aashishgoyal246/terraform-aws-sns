#Module      : SNS
#Description : Output of resources created on AWS.
output "sns_topic_arn" {
  value       = module.sns.sns_topic_arn
  description = "The ARN of the SNS topic."
}

output "sns_topic_subscription_arn" {
  value       = module.sns.sns_topic_subscription_arn
  description = "The ARN of the subscription."
}

output "sns_topic_subscription_protocol" {
  value       = module.sns.sns_topic_subscription_protocol
  description = "The protocol being used in subscription."
}

output "tags" {
  value       = module.sns.tags
  description = "A mapping of tags to assign to the resource."
}