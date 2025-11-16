output "layer_arn" {
  description = "ARN of the Lambda layer (includes version)"
  value       = aws_lambda_layer_version.this.arn
}

output "layer_version" {
  description = "Version number of the Lambda layer"
  value       = aws_lambda_layer_version.this.version
}

# Note: aws_lambda_layer_version.arn already includes the version, so it's the qualified ARN
output "layer_qualified_arn" {
  description = "Qualified ARN of the Lambda layer (same as layer_arn)"
  value       = aws_lambda_layer_version.this.arn
}

