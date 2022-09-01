import base64
import boto3
import json
import re

S3_BUCKET = 'my-s3-bucket-112233'
FILE_NANE = 'file.txt'

def get_file_content():
    session = boto3.session.Session()
    s3 = session.resource("s3", endpoint_url="http://localstack:4566")
    s3_object = s3.Bucket(S3_BUCKET).Object(FILE_NANE).get()
    file_content = s3_object["Body"].read()
    return file_content

def default_page(event, context):
    message = '\nHello!\n' 
    return { 
        "isBase64Encoded": False, 
        "statusCode": 200, 
        "headers": { "x-hello": "hi"},
        "body": message
    }

def get_my_file(event, context):
    file_content = get_file_content()
    return { 
        "isBase64Encoded": True, 
        "statusCode": 200, 
        "headers": { "x-hello": "hi"},
        "body": base64.b64encode(file_content)
    }

def get_greet(event,context):
    body = event['body']
    match = re.match(r'name=(.*)', body)
    if not match:
        return {
            "isBase64Encoded": False, 
            "statusCode": 200, 
            "headers": { "x-hello": "hi"},
            "body": "Missing name!"
        }
    return { 
            "isBase64Encoded": False, 
            "statusCode": 200, 
            "headers": { "x-hello": "hi"},
            "body": f"Hello, {match.group(1)}"
    }

def hello_world(event, context):
    if event["httpMethod"] == "GET":
        if event["path"] == "/get-my-file":
            return get_my_file(event, context)
        else:  
            return default_page(event, context)
    if event["httpMethod"] == 'POST' and event['path'] == '/greet':
        return get_greet(event, context)

if __name__ == '__main__':
    hello_world()