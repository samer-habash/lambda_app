resource "aws_cloudwatch_event_rule" "trigger-Lambda" {
  name = "trigger-lambda-app"
  description = "Triggers the Lambda function HelloWorld every 10 minutes"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda-HelloWorld" {
  rule      = aws_cloudwatch_event_rule.trigger-Lambda.name
  target_id = aws_lambda_function.lambda-HelloWorld.id
  arn = aws_lambda_function.lambda-HelloWorld.arn
}