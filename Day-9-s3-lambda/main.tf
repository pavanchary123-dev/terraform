provider "aws" {
  region = var.aws_region
}

############################
# S3 BUCKET
############################
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.bucket_name
}

############################
# ZIP THE PYTHON FILE
############################
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_code"
  output_path = "${path.module}/lambda_code.zip"
}
############################
# UPLOAD ZIP TO S3
############################
resource "aws_s3_object" "lambda_zip_upload" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda/lambda_code.zip"
  source = data.archive_file.lambda_zip.output_path
}

############################
# IAM ROLE FOR LAMBDA
############################
resource "aws_iam_role" "lambda_role" {
  name = "lambda_s3_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

############################
# IAM POLICY ATTACHMENT
############################
resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

############################
# LAMBDA FUNCTION (CODE FROM S3)
############################
resource "aws_lambda_function" "lambda_from_s3" {
  function_name = "lambda-code-from-s3"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_zip_upload.key

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}
