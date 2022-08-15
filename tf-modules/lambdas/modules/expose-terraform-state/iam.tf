locals {
  s3_bucket_name = try(var.environment_variables.bucket_name, "")
}


module "extract_terraform_state_exec_role" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam/modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]

  create_role = true

  role_name         = "extract-terraform-state-exec-role"
  role_description  = "Role to be assumed by lambda to extract terrafrom state"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaRole",
    aws_iam_policy.this.arn
  ]

  tags = var.tags
}


resource "aws_iam_policy" "this" {
  name        = "extract-terraform-state-policy"
  path        = "/"
  description = "Policy for extracting the state from s3 bucket"

  policy = data.aws_iam_policy_document.this.json
}


data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    resources = ["*"]
  }
  statement {
    sid = "AllowS3TerraformStateAccess"

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}",
      "arn:aws:s3:::${local.s3_bucket_name}/*"
    ]
  }

}

