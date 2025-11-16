output "api_id" {
  description = "ID of the API Gateway"
  value       = aws_apigatewayv2_api.this.id
}

output "api_endpoint" {
  description = "Endpoint of the API Gateway"
  value       = aws_apigatewayv2_api.this.api_endpoint
}

output "execution_arn" {
  description = "Execution ARN of the API Gateway"
  value       = aws_apigatewayv2_api.this.execution_arn
}

output "stage_endpoints" {
  description = "Map of stage names to their full endpoints"
  value = {
    for stage_name, stage in aws_apigatewayv2_stage.this :
    stage_name => "${aws_apigatewayv2_api.this.api_endpoint}/${stage_name}"
  }
}

output "route_integrations" {
  description = "Map of route keys to their integration IDs"
  value = {
    for idx, route in var.routes :
    route.route_key => aws_apigatewayv2_integration.this[idx].id
  }
}

