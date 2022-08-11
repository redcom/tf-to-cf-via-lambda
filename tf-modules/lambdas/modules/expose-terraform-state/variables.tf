variable "create_lambda" {
  description = "Condition to create the lambda function"
  type        = bool
  default     = true
}

variable "publish_lambda" {
  description = "Condition to publish the lambda function"
  type        = bool
  default     = true
}

variable "create_role" {
  description = "Condition to publish the lambda function"
  type        = bool
  default     = true
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "attach_network_policy" {
  description = "Controls whether VPC/network policy should be added to IAM role for Lambda Function"
  type        = bool
  default     = true
}

variable "attach_cloudwatch_logs_policy" {
  description = "Controls whether CloudWatch Logs policy should be added to IAM role for Lambda Function"
  type        = bool
  default     = true
}

variable "authorization_type" {
  description = "The type of authentication that the Lambda Function URL uses. Set to 'AWS_IAM' to restrict access to authenticated IAM users only. Set to 'NONE' to bypass IAM authentication and create a public endpoint."
  type        = string
  default     = "AWS_IAM"
}

varible "create_lambda_function_url" {
  description = "Controls whether the Lambda Function URL resource should be created"
  type        = bool
  default     = true
}

variable "maximum_retry_attempts" {
  description = "Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2."
  type        = number
  default     = 0
}

## Tags
variable "tags" {
  description = "Tags for this lambda function"
  type        = map(string)
  default     = {}
}

variable "role_tags" {
  description = "A map of tags to assign to IAM role"
  type        = map(string)
  default = {
    Name = "lambda:role:extract-terraform-state"
  }
}
