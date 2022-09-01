resource "aws_iam_role" "lambda_role" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    },
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:CopyObject",
        "s3:HeadObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::aws_s3_bucket.hello-server-s3.Name",
        "arn:aws:s3:::aws_s3_bucket.hello-server-s3.Name/*"
      ]
    }
  ]
}
EOF
}

data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = "${path.module}/../../../src/hello_server.py"
  output_path = "${path.module}/hello_server.py.zip"
}

resource "aws_lambda_function" "hello_world_lambda" {
  function_name = "pa-hello-world"
  filename      = data.archive_file.lambda_archive.output_path
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.8"
  handler       = "hello_server.hello_world"

  source_code_hash = data.archive_file.lambda_archive.output_base64sha256

  vpc_config {
    subnet_ids          = [var.private_subnet_id]
    security_group_ids  = [var.security_group_id]
  }

  environment {
    variables = {
      "AWS_ACCESS_KEY_ID" = var.AWS_ACCESS_KEY
      "AWS_SECRET_ACCESS_KEY" = var.AWS_SECRET_KEY
    }
  }
}