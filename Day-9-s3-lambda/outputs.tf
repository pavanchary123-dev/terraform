output "s3_bucket_name" {
  value = aws_s3_bucket.lambda_bucket.bucket
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda_from_s3.function_name
}
