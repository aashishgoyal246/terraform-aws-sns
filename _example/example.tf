provider "aws" {
  region = "ap-south-1"  
}

module "sns" {
  source = "../"

  name        = "sns"
  application = "aashish"
  environment = "test"
  label_order = ["environment", "application", "name"]

  enabled        = true
  policy_enabled = true

  allowed_services_for_sns_publish = ["cloudwatch.amazonaws.com"]

  topic_subscribers = {
    sub_1 = {
      protocol = "sms",
      endpoint = "+919660651780"
    },
    sub_2 = {
      protocol = "sms"
      endpoint = "+918078619608"
    }
  }
}