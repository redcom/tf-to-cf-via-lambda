module "this" {
  source = "github.com/terraform-aws-modules/terraform-aws-lambda.git?ref=v3.3.1"

  create  = var.create_lambda
  publish = var.publish_lambda

  function_name = "export-terraform-state"
  description   = "Export terraform state using lambda"
  handler       = "index.terraformState"
  runtime       = "nodejs14.x"

  # prevent default role_creation for this lambda. Create role in iam.tf file
  create_role = false
  lambda_role = module.extract_terraform_state_exec_role.iam_role_arn

  role_name        = "lambda-export-terraform-state"
  role_description = "Lambda role to be used for viewing terrafrom state"
  role_tags        = var.role_tags

  attach_cloudwatch_logs_policy = try(var.attach_cloudwatch_logs_policy, false)
  attach_network_policy         = try(var.attach_network_policy, false)

  ## The type of authentication that the Lambda Function URL uses. Set to 'AWS_IAM' to restrict access to authenticated IAM users only. Set to 'NONE' to bypass IAM authentication and create a public endpoint.
  authorization_type = try(var.authorization_type, "NONE")


  ## Controls whether the Lambda Function URL resource should be created. Used to expose lambda function
  create_lambda_function_url = try(var.create_lambda_function_url, false)

  ## A map that defines environment variables for the Lambda Function.
  environment_variables = var.environment_variables

  ## Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2.
  maximum_retry_attempts = try(var.maximum_retry_attempts, 0)


  use_existing_cloudwatch_log_group = var.use_existing_cloudwatch_log_group


  source_path = {
    path             = "src/export-terraform-state/",
    npm_requirements = true
  }

  timeout     = 300
  memory_size = 128

  tags = merge(
    {
      Name = "lambda::expose-terraform-state"
    },
    var.tags
  )
}
