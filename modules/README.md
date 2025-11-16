# Terraform Modules

This directory contains reusable Terraform modules for the equity management infrastructure.

## Module Structure

### `iam/`
Creates IAM roles with configurable service principals and policies.

**Usage:**
```hcl
module "lambda_iam" {
  source = "./modules/iam"
  
  role_name         = "lambda_execution_role"
  service_principals = ["lambda.amazonaws.com"]
  additional_policies = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}
```

**Outputs:**
- `role_arn` - ARN of the IAM role
- `role_name` - Name of the IAM role
- `role_id` - ID of the IAM role

---

### `lambda-layer/`
Creates Lambda layers for shared dependencies.

**Usage:**
```hcl
module "lambda_layer" {
  source = "./modules/lambda-layer"
  
  layer_name          = "dependencies"
  filename            = "${path.module}/layer.zip"
  compatible_runtimes = ["python3.12"]
}
```

**Outputs:**
- `layer_arn` - ARN of the Lambda layer
- `layer_version` - Version of the Lambda layer
- `layer_qualified_arn` - Qualified ARN of the Lambda layer

---

### `lambda/`
Creates Lambda functions with configurable handlers, runtimes, and environment variables.

**Usage:**
```hcl
module "lambda_function" {
  source = "./modules/lambda"
  
  function_name  = "my-function"
  handler        = "app.handler"
  runtime        = "python3.12"
  source_path    = "${path.module}/function"
  role_arn       = module.iam.role_arn
  layers         = [module.lambda_layer.layer_arn]
  
  environment_variables = {
    ENV = "production"
  }
}
```

**Outputs:**
- `function_arn` - ARN of the Lambda function
- `function_name` - Name of the Lambda function
- `invoke_arn` - Invoke ARN of the Lambda function
- `qualified_arn` - Qualified ARN of the Lambda function

---

### `api-gateway/`
Creates HTTP API Gateway with configurable routes and stages.

**Usage:**
```hcl
module "api_gateway" {
  source = "./modules/api-gateway"
  
  api_name      = "my-api"
  protocol_type = "HTTP"
  aws_region    = "ap-south-1"
  
  routes = [
    {
      route_key              = "GET /endpoint"
      lambda_function_arn    = module.lambda_function.invoke_arn
      integration_type       = "AWS_PROXY"
      payload_format_version = "2.0"
    }
  ]
  
  stages = [{
    name        = "prod"
    auto_deploy = true
    description = "Production stage"
  }]
}
```

**Outputs:**
- `api_id` - ID of the API Gateway
- `api_endpoint` - Endpoint of the API Gateway
- `execution_arn` - Execution ARN of the API Gateway
- `stage_endpoints` - Map of stage names to their full endpoints

---

## Extending the Infrastructure

### Adding a New Lambda Function

1. Add a new module block in `main.tf`:
```hcl
module "new_lambda_function" {
  source = "./modules/lambda"
  
  function_name  = "new-function"
  handler        = "app.handler"
  runtime        = "python3.12"
  source_path    = "${path.module}/new-function"
  role_arn       = module.lambda_iam.role_arn
  layers         = [module.lambda_layer.layer_arn]
}
```

2. Add corresponding variables to `variables.tf` if needed.

3. Add outputs to `outputs.tf` if needed.

### Adding a New API Route

Update the `routes` list in the API Gateway module:
```hcl
routes = [
  {
    route_key              = "GET /login"
    lambda_function_arn    = module.lambda_function.invoke_arn
    integration_type       = "AWS_PROXY"
    payload_format_version = "2.0"
  },
  {
    route_key              = "POST /users"
    lambda_function_arn    = module.new_lambda_function.invoke_arn
    integration_type       = "AWS_PROXY"
    payload_format_version = "2.0"
  }
]
```

### Adding Multiple Environments

Create separate `.tfvars` files:
- `terraform.tfvars.production`
- `terraform.tfvars.staging`
- `terraform.tfvars.development`

Use with: `terraform apply -var-file="terraform.tfvars.production"`

