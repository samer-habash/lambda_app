lambda_app python3.8 runtime :

- The repo defines a lambda python function that will be created by terraform.

- The terraform will create S3 bucket and upload the app into it , the S3 bucket uses the KMS feature .

Note that I have added acl read access to public , the content of the app will not be viewed because of KMS capability.

- The function will be triggered every 10 minutes by cloudwatch event.

- 
