variable "api_name" {
  type        = string
  description = "Name of the API Gateway"
}

variable "protocol_type" {
  type        = string
  description = "Protocol type (HTTP or WEBSOCKET)"
  default     = "HTTP"
}

variable "routes" {
  type = list(object({
    route_key = string
    lambda_function_arn = string
    integration_type   = string
    payload_format_version = string
  }))
  description = "List of routes to configure"
}

variable "stages" {
  type = list(object({
    name        = string
    auto_deploy = bool
    description = string
  }))
  description = "List of stages to create"
  default = [{
    name        = "default"
    auto_deploy = true
    description = "Default stage"
  }]
}

variable "cors_configuration" {
  type = object({
    allow_credentials = bool
    allow_headers     = list(string)
    allow_methods    = list(string)
    allow_origins    = list(string)
    expose_headers   = list(string)
    max_age          = number
  })
  description = "CORS configuration"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the API Gateway"
  default     = {}
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

