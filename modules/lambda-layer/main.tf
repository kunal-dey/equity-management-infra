resource "aws_lambda_layer_version" "this" {
  filename            = var.filename
  layer_name          = var.layer_name
  compatible_runtimes = var.compatible_runtimes
  description         = var.description

  source_code_hash = fileexists(var.filename) ? filebase64sha256(var.filename) : null

  # Note: aws_lambda_layer_version does not support tags
}

