lambda_app python3.8 runtime :

- The repo defines a lambda python function that will be created by terraform. (The lambda app is simple hello app)

- The terraform will create S3 bucket and upload the app into it , the S3 bucket uses the KMS feature .

Note that I have added acl read access to public , the content of the app will not be viewed because of KMS capability.

- The function will be triggered every 10 minutes by cloudwatch event.

- Building My own Docker Image for terraform with a preinstalled aws plugin with caching feature .
  This feature will help in doing more speedy CI/CD instead of waiting to install the provider plugins
  Download image : docker pull samer1984/terraform-aws-cached-plugin

- To let the image workds as per your needs, please hard code the version of the plugin in the build image .
  and ofcorse afterwards apply the same version ID in the main.tf .
  - The aws plugin version ID during the creation of the image : 2.62

- Uploading the terraform state file into the S3 bucket and finishing created.
