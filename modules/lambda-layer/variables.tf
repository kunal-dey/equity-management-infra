variable "layer_name" {
  type        = string
  description = "Name of the Lambda layer"
}

variable "filename" {
  type        = string
  description = "Path to the layer zip file"
}

variable "compatible_runtimes" {
  type        = list(string)
  description = "List of compatible Lambda runtimes"
  default     = ["python3.12"]
}

variable "description" {
  type        = string
  description = "Description of the Lambda layer"
  default     = ""
}

# Note: aws_lambda_layer_version does not support tags

