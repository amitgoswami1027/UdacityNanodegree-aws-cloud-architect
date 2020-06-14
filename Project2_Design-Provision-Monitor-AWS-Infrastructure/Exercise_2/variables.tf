# TODO: Define the variable for aws_region
variable "aws_region" {
  type        = string
  description = "The region where the lambda function will be deployed."
  default     = "us-east-1"
}

variable "lambda_function_name" {
  type        = string
  description = "AmitG Lambda function"
  default     = "AmitG_lambda"
}