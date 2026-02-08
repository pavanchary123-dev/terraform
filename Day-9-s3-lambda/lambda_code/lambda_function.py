def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": "Lambda code loaded from S3 successfully!"
    }
