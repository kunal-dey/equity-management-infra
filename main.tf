provider "aws" {
  region     = var.aws_region
}

# IAM Module - Lambda Execution Role
module "lambda_iam" {
  source = "./modules/iam"

  role_name         = var.lambda_role_name
  service_principals = ["lambda.amazonaws.com"]
  tags = {
    Environment = var.environment
    Application = var.application_name
  }
}

# Lambda Layer Module
module "lambda_layer" {
  source = "./modules/lambda-layer"

  layer_name          = var.lambda_layer_name
  filename            = "${path.module}/${var.lambda_layer_filename}"
  compatible_runtimes = var.lambda_compatible_runtimes
  # Note: aws_lambda_layer_version does not support tags
}

# Lambda Function Module
module "lambda_function" {
  source = "./modules/lambda"

  function_name  = var.lambda_function_name
  handler        = var.lambda_handler
  runtime        = var.lambda_runtime
  source_path    = "${path.module}/${var.lambda_source_path}"
  role_arn       = module.lambda_iam.role_arn
  layers         = [module.lambda_layer.layer_arn]

  environment_variables = var.lambda_environment_variables
  timeout              = var.lambda_timeout
  memory_size          = var.lambda_memory_size

  enable_api_gateway_integration = false

  tags = {
    Environment = var.environment
    Application = var.application_name
  }
}

# API Gateway Module
module "api_gateway" {
  source = "./modules/api-gateway"

  api_name      = var.api_gateway_name
  protocol_type = "HTTP"
  aws_region    = var.aws_region

  routes = [
    {
      route_key              = var.api_route_key
      lambda_function_arn    = module.lambda_function.invoke_arn
      integration_type       = "AWS_PROXY"
      payload_format_version = "2.0"
    }
  ]

  stages = var.api_stages

  tags = {
    Environment = var.environment
    Application = var.application_name
  }
}

# Lambda Permission for API Gateway
resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.api_gateway.execution_arn}/*/*"
}
