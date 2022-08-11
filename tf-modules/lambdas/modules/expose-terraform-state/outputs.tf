output "role_name" {
  description = "The name of the IAM role created for the Lambda Function"
  default     = this.lambda_role_name
}

output "role_arn" {
  description = "The ARN of the Lambda Function"
  default     = this.lambda_role_arn
}

output "lambda_function_url" {
  description = "The URL of the Lambda Function URL"
  value       = try(this.function_url, "")
}

output "lambda_environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  value       = try(var.environment_variables, {})
}

# logging
output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group"
  value       = this.lambda_cloudwatch_log_group_arn
}

output "lambda_cloudwatch_log_group_name" {
  description = "The name of the Cloudwatch Log Group"
  value       = this.lambda_cloudwatch_log_group_name
}

