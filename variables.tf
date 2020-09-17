#Module      : LABELS
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "application" {
  type        = string
  default     = ""
  description = "Application (e.g. `aashish`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "enabled" {
  type        = bool
  default     = false
  description = "Flag to control the vpc creation."
}

variable "label_order" {
  type        = list
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "tags" {
  type        = map
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

#Module      : SNS
#Description : Terraform SNS module variables.
variable "kms_master_key_id" {
  type        = string
  default     = ""
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK."
}

variable "policy_enabled" {
  type        = bool
  default     = false
  description = "Whether sns topic policy is enabled or not."
}

variable "allowed_services_for_sns_publish" {
  type        = list(string)
  default     = [""]
  description = "List of allowed services for SNS publish."
}

variable "topic_subscribers" {
  type        = map
  default     = {}
  description = "Map of topic subscription."
}