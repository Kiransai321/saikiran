import boto3
import logging
client = boto3.client('s3')

response = client.create_bucket(
   # ACL='private'|'public-read'|'public-read-write'|'authenticated-read',
    #Bucket='kiransai3214567788',
    CreateBucketConfiguration={
        'LocationConstraint': 'us-east-2'
    },
)
