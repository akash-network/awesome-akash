# minio deployment 

minio is an open source s3 compatible object store. [https://github.com/minio/minio].  For many applications today services for logging and uploading files will assume an s3 compatible storage service.  IFPS is too slow for many machine learning applications where the files be synced are over 2Gb in size and not effective for anything other than archival storage.  

## Env Vars

all s3 clients usually expect the following env vars 

- S3_ENDPOINT_URL=http://...
- AWS_DEFAULT_REGION=us-east-1
- AWS_ACCESS_KEY_ID=minio123456789 
- AWS_SECRET_ACCESS_KEY=minio123456789 

these much match the minio env vars 
- MINIO_ACCESS_KEY=minio123456789
- MINIO_SECRET_KEY=minio123456789


the mino service is exposed on port 9000 and the console is on 9090

## Sharing with other Services 

We have had some issues sharing the S3_ENDPOINT_URL endpoint correctly.  Your options are to use 2 deployments and update the 2nd deployment with the S3_ENDPOINT_URL env variable or to try to add the port the to service url before starting the service.  