//data "aws_iam_role" "check_existence_iam_for_lambda" {
//  name = aws_iam_role.iam_for_lambda.name
//}

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

output "iam-lambda-arn" {
  value = aws_iam_role.iam_for_lambda.arn
}