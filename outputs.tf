output "api_url" {
  description = "Full URL of the API Gateway endpoint"
  value       = "${module.api_gateway.stage_endpoints[var.api_stages[0].name]}/${replace(var.api_route_key, "GET ", "")}"
}

output "api_endpoint" {
  description = "Base endpoint of the API Gateway"
  value       = module.api_gateway.api_endpoint
}

output "api_id" {
  description = "ID of the API Gateway"
  value       = module.api_gateway.api_id
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda_function.function_arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda_function.function_name
}

output "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  value       = module.lambda_function.invoke_arn
}

output "lambda_layer_arn" {
  description = "ARN of the Lambda layer"
  value       = module.lambda_layer.layer_arn
}

output "iam_role_arn" {
  description = "ARN of the IAM role for Lambda"
  value       = module.lambda_iam.role_arn
}

output "stage_endpoints" {
  description = "Map of all stage endpoints"
  value       = module.api_gateway.stage_endpoints
}

