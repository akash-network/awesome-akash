import pandas as pd
from pathlib import Path
import boto3
import os,io
import boto3
import requests


S3_ENDPOINT_URL = os.environ['S3_ENDPOINT_URL']
print(f"using init S3_ENDPOINT_URL: {S3_ENDPOINT_URL }")
# if ":" not in "S3_ENDPOINT_URL":
#     S3_ENDPOINT_URL = f"http://{os.environ['S3_ENDPOINT_URL']}:9000"
#     os.environ['S3_ENDPOINT_URL'] = S3_ENDPOINT_URL
# print(f"using S3_ENDPOINT_URL: {S3_ENDPOINT_URL }")

def upload_file(client, bucket,key, filepath= None):
    if filepath is None:
        fo = io.BytesIO(b'my data stored as file object in RAM')
        client.upload_fileobj(fo, bucket, key)
    else:
        client.upload_file(filepath, bucket, os.path.basename(filepath) ) 
        
client = boto3.client('s3',  endpoint_url= os.environ.get("S3_ENDPOINT_URL"), 
                                       aws_access_key_id= os.environ.get("ACCESS_KEY_ID"),
                                       aws_secret_access_key= os.environ.get("SECRET_ACCESS_KEY"),
                                       region_name= os.environ.get("BUCKET_REGION", "auto"))

client.create_bucket(Bucket="0dataset")
upload_file(client, "dataset",  key="", filepath= '/home/ray/test_upload.py')