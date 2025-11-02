#!/bin/bash
set -x

# LocalStack endpoint
endpoint="--endpoint-url=http://localhost:4567"

# Variables
aws_region="us-east-1"
bucket_name="my-bucket"
lambda_func_name="s3-lambda-function"
role_name="s3-lambda-sns"
email_address="hrushikeshprince@example.com"
sns_topic_name="s3-lambda-sns"

# Clean up existing resources

# Delete Lambda Function (if it exists)
echo "Deleting Lambda Function..."
aws lambda delete-function $endpoint --function-name $lambda_func_name || true

# Delete IAM Role (if it exists)
echo "Deleting IAM Role..."
aws iam delete-role $endpoint --role-name $role_name || true

# Detach IAM Role Policies (if they exist)
echo "Detaching IAM Role Policies..."
aws iam detach-role-policy $endpoint --role-name $role_name --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole || true
aws iam detach-role-policy $endpoint --role-name $role_name --policy-arn arn:aws:iam::aws:policy/AmazonSNSFullAccess || true

# Delete S3 Bucket (if it exists)
echo "Deleting S3 Bucket..."
aws s3api delete-bucket $endpoint --bucket $bucket_name || true

# Delete SNS Topic (if it exists)
echo "Deleting SNS Topic..."
aws sns delete-topic $endpoint --topic-arn arn:aws:sns:us-east-1:000000000000:$sns_topic_name || true

# Create IAM Role (LocalStack mock)
echo "Creating IAM Role..."
aws iam create-role $endpoint --role-name $role_name --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": "sts:AssumeRole",
    "Effect": "Allow",
    "Principal": {
      "Service": "lambda.amazonaws.com"
    }
  }]
}'

# Attach Managed Policies to IAM Role
echo "Attaching policies to IAM Role..."
aws iam attach-role-policy $endpoint --role-name $role_name --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
aws iam attach-role-policy $endpoint --role-name $role_name --policy-arn arn:aws:iam::aws:policy/AmazonSNSFullAccess

# Create S3 Bucket
echo "Creating S3 Bucket..."
aws s3api create-bucket $endpoint --bucket $bucket_name --region $aws_region

# Upload a sample file to the S3 bucket
echo "Uploading sample file to S3..."
echo "This is a test file" > example_file.txt
aws s3 cp $endpoint ./example_file.txt s3://$bucket_name/example_file.txt

# Zip the Lambda function
echo "Zipping Lambda function..."
zip -r s3-lambda-function.zip s3-lambda-function

# Create Lambda Function
echo "Creating Lambda Function..."
aws lambda create-function $endpoint --region $aws_region --function-name $lambda_func_name --runtime python3.9 --handler lambda_function.lambda_handler --memory-size 128 --timeout 30 --role arn:aws:iam::000000000000:role/$role_name --zip-file fileb://./s3-lambda-function.zip

# Add Lambda Permissions for S3 to Invoke
echo "Adding Lambda Permission for S3 to Invoke..."
aws lambda add-permission $endpoint --function-name $lambda_func_name --statement-id allow-s3 --action lambda:InvokeFunction --principal s3.amazonaws.com --source-arn arn:aws:s3:::$bucket_name

# Create SNS Topic
echo "Creating SNS Topic..."
sns_topic_arn=$(aws sns create-topic $endpoint --name $sns_topic_name --output text)

# Subscribe to SNS Topic via email
echo "Subscribing to SNS Topic..."
aws sns subscribe $endpoint --topic-arn $sns_topic_arn --protocol email --notification-endpoint $email_address

# Put S3 Bucket Notification Configuration to trigger Lambda
echo "Setting up S3 bucket notification configuration..."
aws s3api put-bucket-notification-configuration $endpoint --bucket $bucket_name --notification-configuration '{
  "LambdaFunctionConfigurations": [{
    "LambdaFunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:'$lambda_func_name'",
    "Events": ["s3:ObjectCreated:*"]
  }]
}'

# Output Success Message
echo "Resources created successfully!"

# Health Check (to confirm services are running)
curl http://localhost:4567/_localstack/health

