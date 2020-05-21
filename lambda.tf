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