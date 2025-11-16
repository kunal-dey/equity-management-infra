resource "aws_apigatewayv2_api" "this" {
  name          = var.api_name
  protocol_type = var.protocol_type

  dynamic "cors_configuration" {
    for_each = var.cors_configuration != null ? [var.cors_configuration] : []
    content {
      allow_credentials = cors_configuration.value.allow_credentials
      allow_headers     = cors_configuration.value.allow_headers
      allow_methods    = cors_configuration.value.allow_methods
      allow_origins    = cors_configuration.value.allow_origins
      expose_headers   = cors_configuration.value.expose_headers
      max_age          = cors_configuration.value.max_age
    }
  }

  tags = var.tags
}

resource "aws_apigatewayv2_integration" "this" {
  for_each = { for idx, route in var.routes : idx => route }

  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = each.value.integration_type
  integration_uri    = each.value.lambda_function_arn
  payload_format_version = each.value.payload_format_version
}

resource "aws_apigatewayv2_route" "this" {
  for_each = { for idx, route in var.routes : idx => route }

  api_id    = aws_apigatewayv2_api.this.id
  route_key = each.value.route_key

  target = "integrations/${aws_apigatewayv2_integration.this[each.key].id}"
}

resource "aws_apigatewayv2_stage" "this" {
  for_each = { for stage in var.stages : stage.name => stage }

  api_id      = aws_apigatewayv2_api.this.id
  name        = each.value.name
  auto_deploy = each.value.auto_deploy
  description = each.value.description

  tags = var.tags
}

