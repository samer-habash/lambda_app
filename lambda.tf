resource "aws_iam_role" "iam_for_lambda" {
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
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda-HelloWorld" {
  filename = "app.zip"
  function_name = "HelloWorldFunction"
  // The filename.handler-method value in your function. For example, "main.handler" calls the handler method defined in main.py.
  handler = "app.handler"
  role = aws_iam_role.iam_for_lambda.arn
  source_code_hash = aws_s3_bucket_object.app-file.key
  runtime = "python3.8"
  memory_size = 128
}