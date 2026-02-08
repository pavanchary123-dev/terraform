provider "aws" {
  
}
resource "aws_iam_role" "Lambda" {
    name = "lambda-role"
      assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}
resource "aws_iam_role_policy_attachment" "name" {
    role = aws_iam_role.Lambda.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  
}
resource "aws_lambda_function" "name" {
    function_name = "new-terr"
    role =aws_iam_role.Lambda.arn
    runtime = "python3.14"
    timeout = 900
    handler ="app.lambda_handler"
    memory_size = 128
    filename = "app.zip"
    source_code_hash =filebase64sha256("app.zip")
     #Without source_code_hash, Terraform might not detect when the code in the ZIP file has changed — meaning your Lambda might not update even after uploading a new ZIP.

#This hash is a checksum that triggers a deployment
}