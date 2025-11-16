variable "aws_region" {
  type    = string
  default = "ap-south-1"
}


variable "github_owner" {
  type    = string
  default = "kunal-dey"
}

variable "github_repo" {
  type    = string
  default = "lambda-test"
  # e.g. "lambda-test"
}

variable "artifact_bucket_name" {
  type    = string
  default = "ci-artifacts-bucket-aws-equity-management"
}

variable "github_branch" {
  type    = string
  default = "main"
}

variable "codebuild_image" {
  type    = string
  default = "aws/codebuild/standard:7.0"
}

# Application Configuration
variable "environment" {
  type        = string
  description = "Environment name (e.g., production, staging, development)"
  default     = "production"
}

variable "application_name" {
  type        = string
  description = "Name of the application"
  default     = "equity-management"
}

# Lambda Configuration
variable "lambda_role_name" {
  type        = string
  description = "Name of the IAM role for Lambda execution"
  default     = "lambda_execution_role"
}

variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function"
  default     = "fetch_request_token"
}

variable "lambda_handler" {
  type        = string
  description = "Lambda function handler"
  default     = "app.fetch_request_token"
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda runtime"
  default     = "python3.12"
}

variable "lambda_source_path" {
  type        = string
  description = "Path to the Lambda function source code directory (relative to root)"
  default     = "login"
}

variable "lambda_environment_variables" {
  type        = map(string)
  description = "Environment variables for the Lambda function"
  default = {
    ENVIRONMENT = "production"
    LOG_LEVEL   = "info"
  }
}

variable "lambda_timeout" {
  type        = number
  description = "Lambda function timeout in seconds"
  default     = 3
}

variable "lambda_memory_size" {
  type        = number
  description = "Lambda function memory size in MB"
  default     = 128
}

# Lambda Layer Configuration
variable "lambda_layer_name" {
  type        = string
  description = "Name of the Lambda layer"
  default     = "kiteconnect-dependencies"
}

variable "lambda_layer_filename" {
  type        = string
  description = "Filename of the Lambda layer zip file (relative to root)"
  default     = "lambda-layer-al2023.zip"
}

variable "lambda_compatible_runtimes" {
  type        = list(string)
  description = "List of compatible Lambda runtimes for the layer"
  default     = ["python3.12"]
}

# API Gateway Configuration
variable "api_gateway_name" {
  type        = string
  description = "Name of the API Gateway"
  default     = "fetch-http-api"
}

variable "api_route_key" {
  type        = string
  description = "Route key for the API Gateway (e.g., 'GET /login')"
  default     = "GET /login"
}

variable "api_stages" {
  type = list(object({
    name        = string
    auto_deploy = bool
    description = string
  }))
  description = "List of API Gateway stages"
  default = [{
    name        = "login_stage"
    auto_deploy = true
    description = "Login API stage"
  }]
}