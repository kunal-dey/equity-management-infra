variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "handler" {
  type        = string
  description = "Lambda function handler"
}

variable "runtime" {
  type        = string
  description = "Lambda runtime"
  default     = "python3.12"
}

variable "source_path" {
  type        = string
  description = "Path to the Lambda function source code directory"
}

variable "output_path" {
  type        = string
  description = "Path where the deployment package will be created"
  default     = ""
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for the Lambda function"
}

variable "layers" {
  type        = list(string)
  description = "List of Lambda layer ARNs to attach"
  default     = []
}

variable "environment_variables" {
  type        = map(string)
  description = "Environment variables for the Lambda function"
  default     = {}
}

variable "timeout" {
  type        = number
  description = "Lambda function timeout in seconds"
  default     = 3
}

variable "memory_size" {
  type        = number
  description = "Lambda function memory size in MB"
  default     = 128
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Lambda function"
  default     = {}
}

variable "reserved_concurrent_executions" {
  type        = number
  description = "Reserved concurrent executions for the Lambda function"
  default     = -1
}

variable "enable_api_gateway_integration" {
  type        = bool
  description = "Enable API Gateway integration permission"
  default     = false
}

variable "api_gateway_source_arn" {
  type        = string
  description = "Source ARN for API Gateway integration (required if enable_api_gateway_integration is true)"
  default     = ""
}

