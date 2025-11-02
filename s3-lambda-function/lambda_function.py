import json
import boto3

def lambda_handler(event, context):
    print("=== Event Received ===")
    print(json.dumps(event, indent=2))

    # Connect to SNS
    sns = boto3.client('sns', endpoint_url="http://localhost:4566")

    topic_arn = "arn:aws:sns:us-east-1:000000000000:s3-lambda-sns"
    message = f"A new object was created in S3. Event details: {json.dumps(event)}"

    # Publish message to SNS
    sns.publish(
        TopicArn=topic_arn,
        Subject="New S3 Object Created",
        Message=message
    )

    return {"status": "success", "message": "SNS notification sent"}

