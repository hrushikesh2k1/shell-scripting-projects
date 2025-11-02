#!/bin/bash
set -x

# LocalStack endpoint
endpoint="--endpoint-url=http://localhost:4566"

# Variables
aws_region="us-east-1"
bucket_name="my-bucket"
lambda_func_name="s3-lambda-function"
role_arn="arn:aws:iam::000000000000:role/lambda-execution-role"
sns_topic_name="s3-lambda-sns"

# Clean up existing resources
aws lambda delete-function $endpoint --function-name $lambda_func_name || true
aws s3api delete-bucket $endpoint --bucket $bucket_name || true
aws sns delete-topic $endpoint --topic-arn arn:aws:sns:$aws_region:000000000000:$sns_topic_name || true

# Create S3 Bucket
aws s3api create-bucket $endpoint --bucket $bucket_name --region $aws_region

# Upload a sample file to the S3 bucket
echo "This is a test file" > example_file.txt
aws s3 cp $endpoint ./example_file.txt s3://$bucket_name/example_file.txt

# Zip the Lambda function
rm -f s3-lambda-function.zip
zip -r s3-lambda-function.zip s3-lambda-function

# Create Lambda Function
aws lambda create-function $endpoint \
  --region $aws_region \
  --function-name $lambda_func_name \
  --runtime python3.9 \
  --handler lambda_function.lambda_handler \
  --memory-size 128 \
  --timeout 30 \
  --role $role_arn \
  --zip-file fileb://./s3-lambda-function.zip

# Allow S3 to invoke Lambda
aws lambda add-permission $endpoint \
  --function-name $lambda_func_name \
  --statement-id allow-s3 \
  --action lambda:InvokeFunction \
  --principal s3.amazonaws.com \
  --source-arn arn:aws:s3:::$bucket_name

# Create SNS Topic
sns_topic_arn=$(aws sns create-topic $endpoint --name $sns_topic_name --output text)

# Subscribe Lambda to SNS Topic (instead of email)
aws sns subscribe $endpoint \
  --topic-arn $sns_topic_arn \
  --protocol lambda \
  --notification-endpoint arn:aws:lambda:$aws_region:000000000000:function:$lambda_func_name

# Set up S3 bucket notification to trigger Lambda
aws s3api put-bucket-notification-configuration $endpoint \
  --bucket $bucket_name \
  --notification-configuration "{
    \"LambdaFunctionConfigurations\": [{
      \"LambdaFunctionArn\": \"arn:aws:lambda:$aws_region:000000000000:function:$lambda_func_name\",
      \"Events\": [\"s3:ObjectCreated:*\"]}]}
  "

curl http://localhost:4566/_localstack/health
echo "Resources created successfully!"
