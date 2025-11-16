variable "role_name" {
  type        = string
  description = "Name of the IAM role"
}

variable "service_principals" {
  type        = list(string)
  description = "List of AWS service principals that can assume this role"
  default     = ["lambda.amazonaws.com"]
}

variable "additional_policies" {
  type        = list(string)
  description = "List of additional IAM policy ARNs to attach to the role"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the IAM role"
  default     = {}
}

