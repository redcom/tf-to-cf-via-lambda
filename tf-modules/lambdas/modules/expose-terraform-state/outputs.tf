output "lambda_function_url" {
  description = "The URL of the Lambda Function URL"
  value       = try(module.this.lambda_function_url, "")
}

output "lambda_environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  value       = try(var.environment_variables, {})
}

# logging
output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group"
  value       = module.this.lambda_cloudwatch_log_group_arn
}

output "lambda_cloudwatch_log_group_name" {
  description = "The name of the Cloudwatch Log Group"
  value       = module.this.lambda_cloudwatch_log_group_name
}

