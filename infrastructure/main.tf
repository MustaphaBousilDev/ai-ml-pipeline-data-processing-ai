provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
}

resource "aws_kinesis_stream" "data_stream" {
  name             = var.stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_period
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "data-processing-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_kinesis_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaKinesisExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name
}




resource "aws_lambda_function" "data_processing_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "data-processing-lambda"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("lambda_function.zip")
}